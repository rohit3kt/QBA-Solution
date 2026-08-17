report 50030 "Change Sales Posting Date"
{
    AdditionalSearchTerms = 'Change Posting Date,Change Document Date,Change Due Date';
    Caption = 'Change Sales Posting Date';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;
    //AllowScheduling = true;
    Permissions =
                TableData "User Setup" = rm,
                TableData "Sales Invoice Header" = rm,
                TableData "Sales Invoice Line" = rm,
                TableData "G/L Entry" = rm,
                TableData "Cust. Ledger Entry" = rm,
                TableData "Detailed Cust. Ledg. Entry" = rm,
                TableData "GST Ledger Entry" = rm,
                TableData "Detailed GST Ledger Entry" = rm,
                TableData "Detailed GST Ledger Entry Info" = rm,
                TableData "Value Entry" = rm;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.", "Posting Date")
                                order(descending);
            column(No; "No.") { }
            trigger OnAfterGetRecord()
            var
            begin
                SalesInHeader.Reset();
                SalesInHeader.SetRange("No.", "Sales Invoice Header"."No.");
                if SalesInHeader.FindFirst() then begin
                    if DocumentDate <> 0D then
                        SalesInHeader.Validate("Document Date", DocumentDate);
                    if PostingDate <> 0D then
                        SalesInHeader.Validate("Posting Date", PostingDate);
                    if ShipmentDate <> 0D then
                        SalesInHeader.Validate("Shipment Date", ShipmentDate);
                    if OrderDate <> 0D then
                        SalesInHeader."Order Date" := OrderDate;
                    if DueDate <> 0D then
                        SalesInHeader."Due Date" := DueDate;
                    if VATReportingDate <> 0D then
                        SalesInHeader."VAT Reporting Date" := VATReportingDate;
                    if PaymentDate <> PaymentDate::" " then
                        SalesInHeader."Payment Date" := PaymentDate;
                    SalesInHeader.Modify();

                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if SalesInvLine.FindSet() then
                        repeat
                            SalesInvLine."Posting Date" := PostingDate;
                            SalesInvLine."Shipment Date" := ShipmentDate;
                            SalesInvLine.Modify();
                        until SalesInvLine.Next() = 0;

                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if GLEntry.FindSet() then
                        repeat
                            GLEntry."Document Date" := DocumentDate;
                            GLEntry."Posting Date" := PostingDate;
                            GLEntry."VAT Reporting Date" := VATReportingDate;
                            GLEntry.Modify();
                        until GLEntry.Next() = 0;

                    CustLedgEntry.Reset();
                    CustLedgEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if CustLedgEntry.FindSet() then
                        repeat
                            CustLedgEntry."Document Date" := DocumentDate;
                            CustLedgEntry."Posting Date" := PostingDate;
                            CustLedgEntry."Due Date" := DueDate;
                            CustLedgEntry.Modify();
                        until CustLedgEntry.Next() = 0;

                    DetailCustLedgEntry.Reset();
                    DetailCustLedgEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if DetailCustLedgEntry.FindSet() then
                        repeat
                            DetailCustLedgEntry."Posting Date" := PostingDate;
                            DetailCustLedgEntry."Initial Entry Due Date" := DueDate;
                            DetailCustLedgEntry.Modify();
                        until DetailCustLedgEntry.Next() = 0;

                    DetailGSTLedgEntry.Reset();
                    DetailGSTLedgEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if DetailGSTLedgEntry.FindSet() then
                        repeat
                            DetailGSTLedgEntry."Posting Date" := PostingDate;
                            DetailGSTLedgEntry.Modify();
                        until DetailGSTLedgEntry.Next() = 0;

                    GSTLedgEntry.Reset();
                    GSTLedgEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if GSTLedgEntry.FindSet() then
                        repeat
                            GSTLedgEntry."Posting Date" := PostingDate;
                            GSTLedgEntry.Modify();
                        until GSTLedgEntry.Next() = 0;

                    DetailGSTLedgEntry.Reset();
                    DetailGSTLedgEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if GSTLedgEntry.FindSet() then
                        repeat
                            GSTLedgEntry."Posting Date" := PostingDate;
                            GSTLedgEntry.Modify();
                        until GSTLedgEntry.Next() = 0;

                    ValueEntry.Reset();
                    ValueEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if ValueEntry.FindSet() then
                        repeat
                            ValueEntry."Document Date" := DocumentDate;
                            ValueEntry."Posting Date" := PostingDate;
                            ValueEntry.Modify();
                        until ValueEntry.Next() = 0;
                    Counter += 1;
                end;
            end;

            trigger OnPostDataItem()
            var
            begin
                Message('%1 Record Deleted Successfully', Counter);
            end;

            trigger OnPreDataItem()
            var
            begin
                Counter := 0;
                if DocumentNo <> '' then
                    "Sales Invoice Header".SetRange("No.", DocumentNo);

                // if ((StartDate <> 0D) AND (EndDate <> 0D)) then
                //     "Vendor Ledger Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                // if ((StartDate = 0D) AND (EndDate <> 0D)) then
                //     "Vendor Ledger Entry".SetFilter("Posting Date", '%1..%2', 0D, EndDate);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        SaveValues = false;
        ShowFilter = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter: Document Date';
                    field(DocumentNo; DocumentNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesInvHeader: Record "Sales Invoice Header";
                        begin
                            SalesInvHeader.Reset();
                            if Page.RunModal(Page::"QBA Posted Sales Invoices", SalesInvHeader) = Action::LookupOK then begin
                                //DocumentNo := VendorLedgerEntry_L."Document No.";
                                Text := SalesInvHeader."No.";
                                DocumentDate := SalesInvHeader."Document Date";
                                PostingDate := SalesInvHeader."Posting Date";
                                ShipmentDate := SalesInvHeader."Shipment Date";
                                DueDate := SalesInvHeader."Due Date";
                                OrderDate := SalesInvHeader."Order Date";
                                VATReportingDate := SalesInvHeader."VAT Reporting Date";
                                //PaymentDate := SalesInvHeader."Payment Date";
                                exit(true);
                            end;
                        end;

                        trigger OnValidate()
                        begin
                            if DocumentNo <> '' then
                                AllEntries := false;
                        end;
                    }
                    field(StartDate; DocumentDate)
                    {
                        Caption = 'Document Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            // if DocumentDate <> 0D then
                            //     AllEntries := false;
                        end;
                    }
                    field(EndDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            // if EndDate <> 0D then
                            //     AllEntries := false;
                        end;
                    }
                    field(DueDate; DueDate)
                    {
                        Caption = 'Due Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            // if EndDate <> 0D then
                            //     AllEntries := false;
                        end;
                    }
                    field(ShipmentDate; ShipmentDate)
                    {
                        Caption = 'Shipment Date';
                        ApplicationArea = All;
                    }
                    field(OrderDate; OrderDate)
                    {
                        Caption = 'Order Date';
                        ApplicationArea = All;
                    }
                    field(VatPostingDate; VATReportingDate)
                    {
                        Caption = 'VAT Reporting Date';
                        ApplicationArea = All;
                    }
                    field(PaymentDate; PaymentDate)
                    {
                        Caption = 'Payment Date';
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
            }
        }

        //     actions
        //     {
        //         area(processing)
        //         {
        //             action(LayoutName)
        //             {
        //                 ApplicationArea = All;

        //             }
        //         }
        //     }
        // }

        // rendering
        // {
        //     layout(LayoutName)
        //     {
        //         Type = Excel;
        //         LayoutFile = 'mySpreadsheet.xlsx';
        //     }
    }

    var
        myInt: Integer;
        DocumentNo: Code[20];
        DocumentDate: Date;
        PostingDate: Date;
        DueDate: Date;
        OrderDate: Date;
        ShipmentDate: Date;
        VATReportingDate: Date;
        PaymentDate: Enum "GST Rate Change";
        UserSetup_G: Record "User Setup";
        AllEntries: Boolean;
        Counter: Integer;
        SalesInHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DetailCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GSTLedgEntry: Record "GST Ledger Entry";
        DetailGSTLedgEntry: Record "Detailed GST Ledger Entry";
        DetailedGSTLedgEntryInfo: Record "Detailed GST Ledger Entry Info";
        ValueEntry: Record "Value Entry";

    trigger OnInitReport()
    begin
        Clear(DocumentNo);
        AllEntries := false;
        UserSetup_G.Get(UserId);
        if not UserSetup_G."Special Permission" then
            Error('You Do not have Special Permission to Run this Report \ Please Connect Administrator to Provide you Permission');
    end;
}