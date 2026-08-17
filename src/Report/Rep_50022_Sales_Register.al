report 50022 Sales_Register
{
    ApplicationArea = All;
    Caption = 'Sales Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(No_; "No.")
            {
            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Posting_Date; format("Posting Date"))
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Order_Date; format("Order Date"))
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
            column(cname; reccompinfo.Name)
            {
            }
            column(Picture; reccompinfo.Picture)
            {
            }
            column(caddress; reccompinfo.Address + ', ' + reccompinfo."Address 2" + ', ' + reccompinfo.City + ', ' + reccompinfo."Post Code" + ' ' + reccompinfo."State Code" + ' ' + reccompinfo."Country/Region Code")
            {
            }
            column(custaddress; custaddress)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(fromdate; format(fromdate))
            {
            }
            column(Todate; format(Todate))
            {
            }
            column(TdsAmt; tdsTotal)
            {
            }
            column(TdsPer; TdsPer)
            {
            }
            column(LR_RR_No_; "LR/RR No.")
            {
            }
            column(LR_RR_Date; "LR/RR Date")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Shipment_Date; format("Shipment Date"))
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }
            column(State; reccompinfo."State Code")
            {
            }
            column(GST_Customer_Type; "GST Customer Type")
            {
            }
            column(GST_Bill_to_State_Code; "GST Bill-to State Code")
            {
            }
            //column(sell)
            column(CompGST; reccompinfo."GST Registration No.")
            {
            }
            column(custgst; custgst)
            {
            }
            column(Nature_of_Supply; NatureofSupply) { }
            column(Document_Date; format("Document Date")) { }
            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Type; Type)
                {
                }
                column(Item_No_; "No.")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Description; Description + ' ' + "Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                //column(Unit_of_Measure_Code;"Unit of Measure Code")
                column(Unit_Price; "Unit Price")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(igstAmt; igstAmt)
                {
                }
                column(igstper; igstper)
                {
                }
                column(cgstAmt; cgstAmt)
                {
                }
                column(cgstper; cgstper)
                {
                }
                column(Line_Discount; "Line Discount %") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                trigger OnAfterGetRecord()
                begin
                    clear(igstAmt);
                    Clear(igstper);
                    Clear(cgstAmt);
                    Clear(cgstper);
                    detgst.Reset();
                    detgst.SetRange("Document No.", SalesInvoiceLine."Document No.");
                    detgst.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                    if detgst.FindFirst() then begin
                        if detgst."GST Component Code" = 'IGST' then begin
                            igstper := detgst."GST %";
                            igstAmt := detgst."GST Amount";
                        end
                        else if detgst."GST Component Code" <> 'IGST' then begin
                            cgstper := detgst."GST %";
                            cgstAmt := detgst."GST Amount";
                        end;
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                reccompinfo.get;
                reccompinfo.CalcFields(Picture);
                SalesInvoiceHeader.SetFilter("Posting Date", '%1..%2', fromdate, Todate);
            end;

            trigger OnAfterGetRecord()
            begin

                if recstate.Get(reccompinfo."State Code") then
                    statename := recstate.Description;

                if reccountry.Get(reccompinfo."Country/Region Code") then
                    countryname := reccountry.Name;

                //tds
                purchaseInvLine.Reset();
                purchaseInvLine.SetRange(purchaseInvLine."Document No.", SalesInvoiceHeader."No.");
                if purchaseInvLine.Findfirst() then
                    repeat
                        GetTDSAmount(purchaseInvLine.RecordId); //TDS
                        tdsTotal += TotalTDSAmt;
                    // TdsPer := 
                    Until purchaseInvLine.Next() = 0;
                Clear(custgst);
                Clear(custaddress);
                reccust.Reset();
                reccust.setrange("No.", SalesInvoiceHeader."Bill-to Customer No.");
                if reccust.FindFirst() then begin
                    custgst := reccust."GST Registration No.";
                    custaddress := reccust.Address + ', ' + reccust."Address 2" + ', ' + reccust.City + ', ' + reccust."Post Code" + ', ' + reccust."State Code" + ', ' + reccust."Country/Region Code";
                end;

                if Customer.Get(SalesInvoiceHeader."Sell-to Customer No.") then begin
                    if Customer."GST Customer Type" = Customer."GST Customer Type"::Registered then
                        NatureofSupply := 'B2B'
                    else
                        NatureofSupply := '';
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
            LayoutFile = './src/Report Layout/Sales Register.rdl';
        }
    }
    var
        reccust: Record 18;
        custgst: code[20];
        custaddress: text;
        purchaseInvLine: Record 113;
        detgst: Record "Detailed GST Ledger Entry";
        reccompinfo: Record 79;
        recstate: Record State;
        reccountry: Record "Country/Region";
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
        tdsTotal: Decimal;
        TotalTDSAmt: Decimal;
        NatureofSupply: Text[10];
        Customer: Record Customer;

    local procedure GetTDSAmount(RecID: RecordID)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        Clear(TdsAmt);
        Clear(TdsPer);
        if not GSTSetup.Get() then exit;
        Clear(tdsTotal);
        Clear(TotalTDSAmt);
        Clear(TdsAmt);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            repeat
                TdsAmt := TaxTransactionValue.Amount;
                TotalTDSAmt := Round(TdsAmt, 1, '=');
                TdsPer := TaxTransactionValue.Percent;
            until TaxTransactionValue.Next() = 0;
        // tdsTotal := TotalTDSAmt;
    end;
}
