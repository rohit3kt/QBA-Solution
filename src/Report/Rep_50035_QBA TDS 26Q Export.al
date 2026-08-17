report 50035 "QBA TDS 26Q Export"
{
    Caption = 'QBA TDS 26Q Export';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem(Integer; Integer)
        {
            dataItemTableView = sorting(Number)
                                where(Number = const(1));

            trigger OnPreDataItem()
            begin
                ValidationsForBlankValues();
                TempExcelBuffer.DeleteAll();
                MakeExcelHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                CreateExcelBody();
                CreateBookandOpenExcel(TDS26QExportReportLbl);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field("Date From"; DateFrom)
                    {
                        Caption = 'Date From';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Species the date from which TDS 26 Q report is to be generated';
                    }
                    field("Date To"; DateTo)
                    {
                        Caption = 'Date To';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Species the date to which TDS 26 Q report is to be generated';
                    }
                    field("TAN No"; TANNo)
                    {
                        Caption = 'T.A.N. No.';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the TAN number on the TDS entry.';
                        TableRelation = "TAN Nos.";
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        TempExcelBuffer.OpenExcel();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SNo: Integer;
        DateFrom: Date;
        DateTo: Date;
        TANNo: Code[10];
        AssesseeCodeType: Text;
        OneLbl: Label '01', Locked = true;
        TwoLbl: Label '02', Locked = true;
        COMLbl: Label 'COM', Locked = true;
        TDS26QExportReportLbl: Label 'TDS26QExportReportTxt', Locked = true;
        SNoLbl: Label 'S.No', Locked = true;
        TypeLbl: Label 'Type', Locked = true;
        PANLbl: Label 'P.A.N', Locked = true;
        NameLbl: Label 'Name', Locked = true;
        SectionLbl: Label 'Section', Locked = true;
        PmtCrDateLbl: Label 'Pmt/Cr Date', Locked = true;
        AmountLbl: Label 'Amount', Locked = true;
        TaxDeductedLbl: Label 'TaX Deducted', Locked = true;
        TaxDepositedLbl: Label 'Tax Deposited', Locked = true;
        DeductionDateLbl: Label 'Deduction Date', Locked = true;
        DeductionRateLbl: Label 'Deduction Rate', Locked = true;
        DeviationReasonTxt: Label 'Deviation Reason', Locked = true;
        DeviationCertificateLbl: Label 'Deviation Certificate', Locked = true;
        InvoiceNoLbl: Label 'Invoice No.', Locked = true;
        ExternalDocNo: Label 'External Document No.', Locked = true;
        FromDateErr: Label 'From date cannot be left blank', Locked = true;
        ToDateErr: Label 'To Date cannot be left blank', Locked = true;
        TANNoErr: Label 'TAN No. cannot be left blank', Locked = true;

    local procedure MakeExcelHeader()
    var
        IsHandled: Boolean;
    begin
        TempExcelBuffer.NewRow();

        OnBeforeMakeExcelHeader(TempExcelBuffer, IsHandled);
        if IsHandled then
            exit;

        TempExcelBuffer.AddColumn(SNoLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TypeLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PANLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(NameLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(SectionLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PmtCrDateLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AmountLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TaxDeductedLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TaxDepositedLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DeductionDateLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DeductionRateLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DeviationReasonTxt, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DeviationCertificateLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(InvoiceNoLbl, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ExternalDocNo, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);

        OnAfterMakeExcelHeader(TempExcelBuffer);
    end;

    local procedure CreateExcelBody()
    var
        Vendor: Record Vendor;
        TDS26QQuery: Query "QBA TDS 26Q";
        IsHandled: Boolean;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        clear(AssesseeCodeType);
        SNo := 0;
        TDS26QQuery.SetFilter(Posting_Date, '%1..%2', DateFrom, DateTo);
        if TANNo <> '' then
            TDS26QQuery.SetFilter(T_A_N__No_, TANNo);

        TDS26QQuery.SetFilter(Assessee_Code, '<>%1', 'NRI');

        OnAfterSetfilterForTDS26QQuery(TDS26QQuery);

        TDS26QQuery.Open();
        while TDS26QQuery.Read() do begin
            SNo += 1;
            TempExcelBuffer.NewRow();

            OnBeforeCreateExcelBody(TempExcelBuffer, TDS26QQuery, IsHandled);
            if IsHandled then
                exit;

            TempExcelBuffer.AddColumn(SNo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            GetVendorAssesseeCode(TDS26QQuery.Assessee_Code);
            TempExcelBuffer.AddColumn(AssesseeCodeType, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(TDS26QQuery.Deductee_PAN_No_, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            Vendor.Get(TDS26QQuery.Vendor_No_);
            TempExcelBuffer.AddColumn(Vendor.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            TempExcelBuffer.AddColumn(TDS26QQuery.Section, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(TDS26QQuery.Posting_Date, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
            TempExcelBuffer.AddColumn(TDS26QQuery.Invoice_Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(TDS26QQuery.TDS_Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(TDS26QQuery.TDS_Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(TDS26QQuery.Posting_Date, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
            TempExcelBuffer.AddColumn(TDS26QQuery.TDS__, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(TDS26QQuery.Document_No, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Vendor No.", TDS26QQuery.Vendor_No_);
            VendorLedgerEntry.SetRange("Document No.", TDS26QQuery.Document_No);
            if VendorLedgerEntry.FindFirst() then
                TempExcelBuffer.AddColumn(VendorLedgerEntry."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            OnAfterCreateExcelBody(TempExcelBuffer, TDS26QQuery);
        end;
        TDS26QQuery.Close();
    end;

    local procedure GetVendorAssesseeCode(AssesseeCode: code[10])
    begin
        case AssesseeCode of
            COMLbl:
                AssesseeCodeType := OneLbl
            else
                AssesseeCodeType := TwoLbl;
        end;
    end;

    local procedure CreateBookandOpenExcel(FileFormatTxt: Text[250])
    begin
        TempExcelBuffer.CreateNewBook(FileFormatTxt);
        TempExcelBuffer.WriteSheet(FileFormatTxt, CompanyName(), UserId());
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    local procedure ValidationsForBlankValues()
    var
        IsHandled: Boolean;
    begin
        OnBeforeValidationsForBlankValues(DateFrom, DateTo, TANNo, IsHandled);
        if IsHandled then
            exit;

        if DateFrom = 0D then
            Error(FromDateErr);

        if DateTo = 0D then
            Error(ToDateErr);

        if TANNo = '' then
            Error(TANNoErr);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMakeExcelHeader(var TempExcelBuffer: Record "Excel Buffer"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeExcelHeader(var TempExcelBuffer: Record "Excel Buffer")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateExcelBody(var TempExcelBuffer: Record "Excel Buffer"; TDS27Q: Query "QBA TDS 26Q"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateExcelBody(var TempExcelBuffer: Record "Excel Buffer"; TDS27Q: Query "QBA TDS 26Q")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidationsForBlankValues(DateFrom: Date; DateTo: Date; TANNo: Code[10]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetfilterForTDS26QQuery(var TDS26QQuery: Query "QBA TDS 26Q")
    begin
    end;
}
