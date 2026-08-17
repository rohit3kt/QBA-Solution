report 50014 "Payment Rec. Against Invoice"
{
    ApplicationArea = All;
    Caption = 'Payment Rec. Against Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = QBA_Report;
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.") WHERE("Document Type" = FILTER(Payment | " "));
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(VendorLedgerEntryFilter; VendorLedgerEntryFilter) { }
            column(SLNo_1; SLNo_1) { }
            column("Vendor_No"; "Vendor No.") { }
            column(Vendor_Name; "Vendor Name") { }
            column(Document_Type; "Document Type") { }
            column(Posting_Date; "Posting Date") { }
            column(PaymentDocument_No; "Document No.") { }
            column(PaymentAmount; Amount) { }
            dataitem(PageLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(VendAddr6; VendAddr[6]) { }
                dataitem(VendorLedgerEntry_2; "Vendor Ledger Entry")
                {
                    DataItemTableView = SORTING("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                    column(SLNo_2; SLNo_2) { }
                    column(INV_Document_No; "Document No.") { }
                    column(Original_Amount; "Original Amount") { }
                    column(External_Document_No; "External Document No.") { }
                    column(INV_Posting_Date; "Posting Date") { }
                    column(Amount; Amount) { }
                    trigger OnPreDataItem()
                    var
                    begin
                        SLNo_2 := 0;
                    end;

                    trigger OnAfterGetRecord()
                    var
                    begin
                        SLNo_2 += 1;
                    end;
                }
            }
            trigger OnPreDataItem()
            var
            begin
                CompanyInfo.GET;
                CompanyInfo.CalcFields(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                GLSetup.GET;
                SLNo_1 := 0;
            end;

            trigger OnAfterGetRecord()//VendorLedgerEntry
            var
            begin
                if TempDocNO <> "Vendor Ledger Entry"."Document No." then
                    SLNo_1 += 1;
                TempDocNO := "Vendor Ledger Entry"."Document No.";
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
        layout(QBA_Report)
        {
            Type = RDLC;
            //LayoutFile = './src/Report Layout/Payment Receipt Against Invoice.xlsx';
            LayoutFile = './src/Report Layout/Payment Receipt Against Invoice.rdl';
        }
    }
    labels
    {
        CurrencyCodeCaption = 'Currency Code';
        PageCaption = 'Page';
        DocDateCaption = 'Document Date';
        EmailCaption = 'E-Mail';
        HomePageCaption = 'Home Page';

    }
    trigger OnPreReport()
    begin
        VendorLedgerEntryFilter := "Vendor Ledger Entry".GetFilters();
    end;

    var


        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit 365;
        ReportTitle: Text[30];
        PaymentDiscountTitle: Text[30];
        CompanyAddr: array[8] of Text[50];
        VendAddr: array[8] of Text[50];
        SLNo_1: Integer;
        SLNo_2: Integer;
        TempDocNO: Code[20];
        VendorLedgerEntryFilter: Text;
}
