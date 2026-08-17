report 50004 "Sales Invoice USD"
{
    ApplicationArea = All;
    Caption = 'Sales Invoice USD';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            //  DataItemTableView = where("No." = filter('*EX*'));//("Currency Code" = filter(<> ''),
            RequestFilterFields = "No.";

            column(Cname; reccompinfo.Name)
            {
            }
            column(DocHeaderPicture; reccompinfo."Document Header Picture")
            {
            }
            column(header; header)
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(IRN; SalesInvoiceHeader."IRN Hash")
            {
            }
            column(CIN; reccompinfo.cin)
            {
            }
            column(msmeno; reccompinfo."MSME No.")
            {
            }
            column(ARN; reccompinfo."ARN No.")
            {
            }
            column(caddress; (reccompinfo.Address + ', ' + reccompinfo."Address 2"))
            {
            }
            column(cadress2; reccompinfo.city + ', ' + reccompinfo."Post Code" + ', ' + reccompinfo."State Code" + ', ' + reccompinfo."Country/Region Code")
            {
            }
            column(cemail; reccompinfo."E-Mail")
            {
            }
            column(reccompinfopostcode; reccompinfo."Post Code")
            {
            }
            column(CGstreg; reccompinfo."GST Registration No.")
            {
            }
            column(compPAn; reccompinfo."P.A.N. No.")
            {
            }
            column(QR_Code; "QR Code")
            {
            }
            column(custACK; custACK)
            {
            }
            column(custGST; custGST)
            {
            }
            column(No; "No.")
            {
            }
            // column(Currency_Code;"Currency Code")
            column(DocumentDate; format("Document Date"))
            {
            }
            column(DueDate; format("Due Date"))
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BilltoAddress; "Bill-to Address" + ',' + "Bill-to Address 2" + ', ' + "Bill-to City" + ', ' + "Bill-to Post Code" + ', ' + custcity + ', ' + "Bill-to Country/Region Code")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoContact; "Bill-to Contact")
            {
            }
            column(BilltoContactNo; "Bill-to Contact No.")
            {
            }
            column(BilltoCounty; "Bill-to County")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Comment; Comment)
            {
            }
            // column(bill)
            column(Cpicture; reccompinfo.Picture)
            {
            }
            column(cHeaderPicture; reccompinfo."Document Header Picture")
            {
            }
            column(headerpicture2; reccompinfo.Picture2)
            {
            }
            //  column(QR_Code; "QR Code") { }
            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                // DataItemTableView = where("No." = filter(<> ''));
                column(No_; "No.")
                {
                }
                column(Description; Description + "Description 2")
                {
                }
                column(SlNo; SlNo)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(cgstper; cgstper)
                {
                }
                column(CGSTamt; CGSTamt)
                {
                }
                column(sgstamt; sgstamt)
                {
                }
                column(sgstper; sgstper)
                {
                }
                column(Igstper; Igstper)
                {
                }
                column(IGSTamt; IGSTamt)
                {
                }
                column(AmtWord; AmtWord[1])
                {
                }
                column(USDorEURO; USDorEURO)
                {
                }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    SlNo := SlNo + 1;
                    // if SalesInvoiceLine."No." = '' then
                    //     CurrReport.Skip();
                    // Clear(cgstper);
                    Clear(CGSTamt);
                    Clear(sgstamt);
                    Clear(sgstper);
                    Clear(Igstper);
                    Clear(IGSTamt);
                    detailedGST.Reset();
                    detailedGST.SetRange("Document No.", SalesInvoiceLine."Document No.");
                    detailedGST.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                    if detailedGST.FindFirst() then begin
                        if detailedGST."GST Component Code" = 'IGST' then begin
                            Igstper := detailedGST."GST %";
                            IGSTamt := detailedGST."GST Amount";
                        end
                        else if detailedGST."GST Component Code" <> 'IGST' then begin
                            cgstper := detailedGST."GST %";
                            CGSTamt := detailedGST."GST Amount";
                            sgstper := detailedGST."GST %";
                            sGSTamt := detailedGST."GST Amount";
                        end;
                    end;
                    //amount in word
                    ///amt to word
                    TotalSGSTAmt := 0;
                    TotalIGSTAmt := 0;
                    TotalCGSTAmount := 0;
                    AmtVendorTotal := 0;
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                    //  SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    If SalesInvoiceLine.FindSet() then
                        repeat
                            Clear(CGSTAmt);
                            Clear(SGSTAmt);
                            Clear(IGSTAmt);
                            GetGSTAmount(SalesInvoiceLine.RecordId);
                            AmtVendorTotal += (CGSTAmt + SGSTAmt + IGSTAmt + SalesInvoiceLine."Amount Including VAT") - (SalesInvoiceLine."Line Discount Amount");
                            TotalCGSTAmount += CGSTAmt;
                            TotalIGSTAmt += IGSTAmt;
                            TotalSGSTAmt += SGSTAmt;
                        until SalesInvoiceLine.Next() = 0;
                    checkreport.InitTextVariable();
                    checkreport.FormatNoText(AmtWord, Abs(AmtVendorTotal), SalesInvoiceHeader."Currency Code");
                    //AmtVendorTotal
                end;
            }
            trigger OnPreDataItem()
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture);
                SalesInvoiceHeader.CalcFields("QR Code");
                reccompinfo.CalcFields("Document Header Picture");
                reccompinfo.CalcFields(Picture2);
                Clear(header);
                // if printDuplicate = false then
                //     header := 'Duplicate'
                // else
                //     if printDuplicate <> false then
                //         header := 'Original for Recipient';
            end;

            trigger OnAfterGetRecord()
            begin
                if printDuplicate = false then
                    header := 'Original for Recipient'
                else if printDuplicate = true then header := 'Duplicate';
                SalesInvoiceHeader.CalcFields("QR Code");
                //
                if SalesInvoiceHeader."Currency Code" = '' then
                    USDorEURO := ''
                else if SalesInvoiceHeader."Currency Code" = 'USD' then
                    USDorEURO := 'USD'
                else if SalesInvoiceHeader."Currency Code" = 'EURO' then USDorEURO := 'EURO';
                ///
                reccustomer.Reset();
                reccustomer.SetRange("No.", "Bill-to Customer No.");
                if reccustomer.FindFirst() then begin
                    // custIRN := reccustomer.irn
                    custGST := reccustomer."GST Registration No.";
                    custACK := reccustomer."ARN No.";
                    custcity := reccustomer.City;
                end;
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
                    // field(printDuplicate; printDuplicate)
                    // {
                    //     Caption = 'Print Duplicate';
                    //     ApplicationArea = all;
                    // }
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
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/Sales Invoice USD.rdl';
        }
    }
    var
        custcity: code[15];
        AmtWord: array[2] of Text[80];
        TotalSGSTAmt: Decimal;
        TotalIGSTAmt: Decimal;
        TotalCGSTAmount: Decimal;
        AmtVendorTotal: Decimal;
        printDuplicate: Boolean;
        custACK: text[100];
        SlNo: Integer;
        custGST: code[20];
        reccompinfo: Record "Company Information";
        recGST: Record "GST Ledger Entry";
        detailedGST: Record "Detailed GST Ledger Entry";
        CGSTamt: Decimal;
        sgstamt: Decimal;
        IGSTamt: Decimal;
        cgstper: Decimal;
        sgstper: Decimal;
        Igstper: Decimal;
        reccustomer: Record Customer;
        custIRN: text[250];
        header: Text[30];
        checkreport: Report "Check Report";
        USDorEURO: code[5];

    trigger OnInitReport()
    begin
        // SalesInvoiceHeader.SetFilter("Currency Code", '<>%1', "");
    end;

    local procedure GetGSTAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        LpurLine: Record 113;
    begin
        if not GSTSetup.Get() then exit;
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            repeat
                if TaxTransactionValue."Value ID" = 2 then begin
                    CGSTAmt += TaxTransactionValue.Amount;
                    CGSTPer := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 6 then begin
                    SGSTAmt += TaxTransactionValue.Amount;
                    SGSTPer := TaxTransactionValue.Percent;
                end;
                if TaxTransactionValue."Value ID" = 3 then begin
                    IGSTAmt += TaxTransactionValue.Amount;
                    IGSTPer := TaxTransactionValue.Percent;
                end;
            until TaxTransactionValue.Next() = 0;
    end;
}
