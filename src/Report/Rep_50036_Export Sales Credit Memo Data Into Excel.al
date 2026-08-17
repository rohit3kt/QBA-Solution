report 50036 "Export Sal Cr Memo Into Excel"
{
    ApplicationArea = All;
    Caption = 'Export Sales Credit Memo Data Into Excel';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    Permissions =
        tabledata "Sales Cr.Memo Header" = R,
        tabledata "Sales Cr.Memo Line" = R;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            trigger OnPreDataItem()
            begin
                // QBACOMP00001
                //  FALedgerEntry.SetFilter("FA No.", '=%1', 'QBACOMP00001');//start date 23-09-2023
            end;

            trigger OnAfterGetRecord()
            var
                TempExcelBuffer: Record "Excel Buffer" temporary;
                GSEntriesLbl: Label 'Exported Sheet';
                ExcelFileName: Label 'Exported Sales Credit Memo File_%1_%2';
                NatureofSupply: Text;
                DocumentNo_L: Code[20];
                Lineno: Integer;
                IsService: Text;

                UnitPrice: Decimal;
                GrossAmount: Decimal;
                TaxableValue: Decimal;
                ItemTotal: Decimal;
                TotalTaxableValue: Decimal;
                TotalInvoiceValue: Decimal;
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                BuyerGSTIN: Code[20];
            begin
                if ((DocumentNo <> '') OR (PostingDate <> 0D)) then begin
                    TempExcelBuffer.Reset();
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.NewRow();

                    TempExcelBuffer.AddColumn('Supply Type Code *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Reverse Charge', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('e-Comm GSTIN', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Igst On Intra', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Document Type *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Document Number *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn('Document Date (DD/MM/YYYY) *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer GSTIN *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Legal Name *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Trade Name ', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer POS *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Addr1 *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Addr2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Location *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Pin Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer State *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Phone Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Buyer Email Id', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch Addr1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch Addr2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch Location', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch Pin Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Dispatch State', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping GSTIN', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Legal Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Trade Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Addr1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Addr2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Location', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Pin Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping State', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Sl.No. *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Product Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Is_Service *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('HSN code *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Bar code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Quantity *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Free Quantity', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Unit *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Unit Price *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Gross Amount *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Discount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Pre Tax Value', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Taxable value *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('GST Rate (%) *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Sgst Amt(Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cgst Amt (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Igst Amt (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cess Rate (%)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cess Amt Adval (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cess Non Adval Amt (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('State Cess Rate (%)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('State Cess Adval Amt (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('State Cess Non-Adval Amt (Rs)', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Other Charges', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Item Total *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Batch Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Batch Expiry Dt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Warranty Dt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Total Taxable value *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Sgst Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cgst Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Igst Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Cess Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('State Cess Amt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Discount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Other charges', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Round off', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Total Invoice value *', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Bill No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Shipping Bill Dt', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Port', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Refund claim', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Foreign Currency', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Country Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Export Duty Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Trans ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Trans Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Trans Mode', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Distance', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Trans Doc No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Trans Doc Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Vehicle No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Vehicle Type', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Error List', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end else
                    Error('Excel Can not be generated without filter');

                SalesCrmemoLine_G.Reset();
                if DocumentNo <> '' then
                    SalesCrmemoLine_G.SetRange("Document No.", DocumentNo);
                if PostingDate <> 0D then
                    SalesCrmemoLine_G.SetRange("Posting Date", PostingDate);
                SalesCrmemoLine_G.SetFilter(Quantity, '<>%1', 0);
                SalesCrmemoLine_G.SetFilter(Type, '<>%1', SalesCrmemoLine_G.Type::" ");
                if SalesCrmemoLine_G.FindSet() then begin
                    repeat
                        if SalesCrmemoLine_G."Document No." = DocumentNo_L then
                            Lineno += 1
                        else
                            Lineno := 1;

                        SalesCrMemoHeader_G.Get(SalesCrmemoLine_G."Document No.");
                        Customer.Get(SalesCrMemoHeader_G."Bill-to Customer No.");
                        State.Get(Customer."State Code");

                        GstComponent(SalesCrmemoLine_G);
                        if Customer."Gen. Bus. Posting Group" = 'DOMESTIC' then begin
                            BuyerGSTIN := Customer."GST Registration No.";
                            NatureofSupply := 'B2B';
                            UnitPrice := SalesCrmemoLine_G."Unit Price";
                            GrossAmount := SalesCrmemoLine_G.Quantity * SalesCrmemoLine_G."Unit Price";
                            TaxableValue := SalesCrmemoLine_G."Line Amount";
                            ItemTotal := SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt;
                            TotalTaxableValue := SalesCrmemoLine_G."Line Amount";
                            TotalInvoiceValue := SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt;
                        end;

                        if Customer."Gen. Bus. Posting Group" = 'EXPORT' then begin
                            NatureofSupply := 'EXPWOP';
                            BuyerGSTIN := 'URP';
                            if Customer."No." <> 'C00014' then begin
                                UnitPrice := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G."Unit Price", SalesCrMemoHeader_G."Currency Factor");
                                GrossAmount := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G.Quantity * SalesCrmemoLine_G."Unit Price", SalesCrMemoHeader_G."Currency Factor");
                                TaxableValue := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G."Line Amount", SalesCrMemoHeader_G."Currency Factor");
                                ItemTotal := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt, SalesCrMemoHeader_G."Currency Factor");
                                TotalTaxableValue := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G."Line Amount", SalesCrMemoHeader_G."Currency Factor");
                                TotalInvoiceValue := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, SalesCrMemoHeader_G."Currency Code", SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt, SalesCrMemoHeader_G."Currency Factor");
                            end else begin
                                UnitPrice := SalesCrmemoLine_G."Unit Price";
                                GrossAmount := SalesCrmemoLine_G.Quantity * SalesCrmemoLine_G."Unit Price";
                                TaxableValue := SalesCrmemoLine_G."Line Amount";
                                ItemTotal := SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt;
                                TotalTaxableValue := SalesCrmemoLine_G."Line Amount";
                                TotalInvoiceValue := SalesCrmemoLine_G."Line Amount" + IGST_Amt + CGST_Amt + SGST_Amt;
                            end;
                        end;


                        if SalesCrmemoLine_G."GST Group Type" = SalesCrmemoLine_G."GST Group Type"::Service then
                            IsService := 'Yes'
                        else
                            IsService := 'No';

                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(NatureofSupply, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        //TempExcelBuffer.AddColumn('Tax Invoice', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('Credit Memo', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(BuyerGSTIN, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(State.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Bill-to Address", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Bill-to Address 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Bill-to City", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Bill-to Post Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(State.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer."Phone No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(Customer."E-Mail", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to GST Reg. No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to Address", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to Address 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to City", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G."Ship-to Post Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrMemoHeader_G.State, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Lineno, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        //TempExcelBuffer.AddColumn(SalesCrmemoLine_G.Description + ' ' + SalesCrmemoLine_G."Description 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(IsService, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G."HSN/SAC Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G."Unit of Measure", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(UnitPrice, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(GrossAmount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G."Line Discount Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TaxableValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        //GstComponent(SalesCrmemoLine_G);
                        TempExcelBuffer.AddColumn(IGST_Rate + CGST_Rate + SGST_Rate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(SGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(CGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(IGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(ItemTotal, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TotalTaxableValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(SGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(CGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(IGST_Amt, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                        TempExcelBuffer.AddColumn(SalesCrmemoLine_G."Line Discount Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('RoundOff', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TotalInvoiceValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                        DocumentNo_L := SalesCrmemoLine_G."Document No.";
                    until SalesCrmemoLine_G.Next() = 0;
                end;

                TempExcelBuffer.CreateNewBook(GSEntriesLbl);
                TempExcelBuffer.WriteSheet(GSEntriesLbl, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();

                //CurrencyExchangeRate.ExchangeAmtFCYToLCY()
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Filter: Sales Invoice Document';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if DocumentNo <> '' then
                                PostingDate := 0D;
                        end;
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesInvoiceHeader_L: Record "Sales Invoice Header";
                        begin
                            SalesInvoiceHeader_L.Reset();
                            if Page.RunModal(Page::"Posted Sales Invoices", SalesInvoiceHeader_L) = Action::LookupOK then begin
                                Text := SalesInvoiceHeader_L."No.";
                                exit(true);
                            end;
                        end;

                        trigger OnValidate()
                        begin
                            if PostingDate <> 0D then
                                DocumentNo := '';
                        end;
                    }

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    local procedure GstComponent(Line: Record "Sales Cr.Memo Line")
    var
        DetGSTLedgEntry: Record "Detailed GST Ledger Entry";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TotalAmountwithoutGST: Decimal;
    begin
        ClearVariable();
        DetGSTLedgEntry.Reset();
        DetGSTLedgEntry.SetRange("Transaction Type", DetGSTLedgEntry."Transaction Type"::Sales);
        DetGSTLedgEntry.SetRange("Document Type", DetGSTLedgEntry."Document Type"::"Credit Memo");
        DetGSTLedgEntry.SetRange("Source Type", DetGSTLedgEntry."Source Type"::Customer);
        DetGSTLedgEntry.SetRange("Document No.", Line."Document No.");
        DetGSTLedgEntry.SetRange("Document Line No.", Line."Line No.");
        if DetGSTLedgEntry.FindSet() then begin
            repeat
                if DetGSTLedgEntry."GST Component Code" = 'IGST' then begin
                    IGST_Amt := ABS(DetGSTLedgEntry."GST Amount");
                    IGST_Rate := ABS(DetGSTLedgEntry."GST %");
                end;
                if DetGSTLedgEntry."GST Component Code" = 'CGST' then begin
                    CGST_Amt := ABS(DetGSTLedgEntry."GST Amount");
                    CGST_Rate := ABS(DetGSTLedgEntry."GST %");
                end;
                if DetGSTLedgEntry."GST Component Code" = 'SGST' then begin
                    SGST_Amt := ABS(DetGSTLedgEntry."GST Amount");
                    SGST_Rate := ABS(DetGSTLedgEntry."GST %");
                end;
            until DetGSTLedgEntry.Next() = 0;
        end;
    end;

    local procedure ClearVariable()
    begin
        IGST_Rate := 0;
        IGST_Amt := 0;
        SGST_Rate := 0;
        SGST_Amt := 0;
        CGST_Rate := 0;
        CGST_Amt := 0;
    end;


    var
        PostingDate: Date;
        DocumentNo: Code[20];
        SalesInvoiceHeader_G: Record "Sales Invoice Header";
        SalesCrMemoHeader_G: Record "Sales Cr.Memo Header";
        SalesInvoiceLine_G: Record "Sales Invoice Line";
        SalesCrmemoLine_G: Record "Sales Cr.Memo Line";
        Customer: Record Customer;
        State: Record State;
        IGST_Rate: Decimal;
        IGST_Amt: Decimal;
        SGST_Rate: Decimal;
        SGST_Amt: Decimal;
        CGST_Rate: Decimal;
        CGST_Amt: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
}
