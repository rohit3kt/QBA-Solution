report 50023 Purchase_Register
{
    ApplicationArea = All;
    Caption = 'Purchase Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(PurchaseInvHeader; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Currency_Code; "Currency Code") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address" + ' ' + "Buy-from Address 2" + ' ' + "Buy-from City" + ' ' + "Buy-from Post Code" + ' ' + VendStatecode + ' ' + "Buy-from Country/Region Code") { }
            column(Posting_Date; format("Posting Date")) { }
            column(Order_No_; "Order No.") { }
            column(Order_Date; format("Order Date")) { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(cname; CompanyInfoRec.Name) { }
            column(Picture; CompanyInfoRec.Picture) { }
            column(caddress; CompanyInfoRec.Address + ' ' + CompanyInfoRec."Address 2" + ' ' + CompanyInfoRec.City + ' ' + CompanyInfoRec."Post Code" + ' ' + CompanyInfoRec."State Code" + ' ' + CompanyInfoRec."Country/Region Code") { }
            column(Amount; Amount) { }
            column(fromdate; format(fromdate)) { }
            column(Todate; format(Todate)) { }
            column(Vehicle_Type; "Vehicle Type") { }
            column(Vehicle_No_; "Vehicle No.") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(State; CompanyInfoRec."State Code") { }
            column(GST_Customer_Type; GSTVendorType) { }
            column(GST_Bill_to_State_Code; VendStatecode) { }
            column(CompGST; CompanyInfoRec."GST Registration No.") { }
            column(custgst; custgst) { }
            column(Nature_of_Supply1; "Nature of Supply") { }
            column(Nature_of_Supply; NatureofSupply) { }
            column(VendStatecode; VendStatecode) { }
            column(Document_Date; Format("Document Date")) { }
            dataitem(PurchInvoiceLine; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(Type; Type) { }
                column(Item_No_; "No.") { }
                column(Description; Description + ' ' + "Description 2") { }
                column(Quantity; Quantity) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Line_Amount; "Line Amount") { }
                column(igstAmt; igstAmt) { }
                column(igstper; igstper) { }
                column(cgstAmt; cgstAmt) { }
                column(cgstper; cgstper) { }
                column(TdsAmt; TdsAmt) { }
                column(TdsPer; TdsPer) { }
                trigger OnPreDataItem()
                begin
                    Clear(TdsAmt);
                    Clear(TdsPer);
                    clear(igstAmt);
                    Clear(igstper);
                    Clear(cgstAmt);
                    Clear(cgstper);
                end;

                trigger OnAfterGetRecord()
                var
                begin
                    if PurchInvoiceLine.Quantity = 0 then
                        ClearVariable();

                    if PurchInvoiceLine."GST Group Code" <> '' then begin
                        DetailedGSTLedgerEntry.Reset();
                        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvoiceLine."Document No.");
                        DetailedGSTLedgerEntry.SetRange("Document Line No.", PurchInvoiceLine."Line No.");
                        if DetailedGSTLedgerEntry.FindFirst() then begin
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                igstper := DetailedGSTLedgerEntry."GST %";
                                igstAmt := DetailedGSTLedgerEntry."GST Amount";
                            end
                            else if DetailedGSTLedgerEntry."GST Component Code" <> 'IGST' then begin
                                cgstper := DetailedGSTLedgerEntry."GST %";
                                cgstAmt := DetailedGSTLedgerEntry."GST Amount";
                            end;
                        end;
                    end;

                    if ((PurchInvoiceLine."TDS Section Code" <> '') OR (PurchInvoiceLine.Quantity = 0)) then
                        GetTDSAmount(PurchInvoiceLine.RecordId);
                end;
            }
            trigger OnPreDataItem()
            begin
                CompanyInfoRec.get;
                CompanyInfoRec.CalcFields(Picture);
                PurchaseInvHeader.SetFilter("Posting Date", '%1..%2', fromdate, Todate);
            end;

            trigger OnAfterGetRecord()
            begin

                if StateRec.Get(CompanyInfoRec."State Code") then
                    statename := StateRec.Description;

                if CountryRegionRec.Get(CompanyInfoRec."Country/Region Code") then
                    countryname := CountryRegionRec.Name;

                if Vendor.Get(PurchaseInvHeader."Buy-from Vendor No.") then begin
                    custgst := Vendor."GST Registration No.";
                    VendStatecode := Vendor."State Code";
                    if Vendor."GST Vendor Type" = Vendor."GST Vendor Type"::Registered then begin
                        GSTVendorType := 'Registered';
                        NatureofSupply := 'B2B';
                    end else begin
                        GSTVendorType := 'Unregistered';
                        NatureofSupply := '';
                    end;
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
                    field(fromdate; fromdate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = all;
                    }
                    field(Todate; Todate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = all;
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
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Report Layout/Purchase Register.rdl';
        }
    }
    var

        custgst: code[20];
        VendStatecode: code[5];
        purchaseInvLine: Record 123;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CompanyInfoRec: Record "Company Information";
        StateRec: Record State;
        CountryRegionRec: Record "Country/Region";
        statename: text;
        countryname: text;
        cgstper: Decimal;
        cgstAmt: Decimal;
        igstper: Decimal;
        igstAmt: Decimal;
        fromdate: date;
        Todate: date;
        TdsAmt: Decimal;
        TdsPer: Decimal;
        NatureofSupply: Text[10];
        Vendor: Record Vendor;
        GSTVendorType: Text[20];


    local procedure GetTDSAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        TempTDS: Decimal;
    begin

        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                TempTDS := TaxTransactionValue.Amount;
                TdsAmt := Round(TempTDS, 1, '=');
                TdsPer := TaxTransactionValue.Percent;
            until TaxTransactionValue.Next() = 0;
    end;

    // local procedure GetTDDAmount(DocNo: Code[20]): Decimal
    // var
    //     TDSEntry: Record "TDS Entry";
    //     TempAmt: Decimal;
    // begin
    //     TDSEntry.Reset();
    //     TDSEntry.SetRange("Document Type", TDSEntry."Document Type"::Invoice);
    //     TDSEntry.SetRange("Document No.", DocNo);
    //     if TDSEntry.FindFirst() then
    //         exit(TDSEntry."TDS Amount");
    // end;
    local procedure ClearVariable()
    begin
        Clear(TdsAmt);
        Clear(TdsPer);
        clear(igstAmt);
        Clear(igstper);
        Clear(cgstAmt);
        Clear(cgstper);
    end;
}
