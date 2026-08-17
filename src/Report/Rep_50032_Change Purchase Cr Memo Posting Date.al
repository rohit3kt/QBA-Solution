report 50032 "Change Pur Cr Memo Post Date"
{
    AdditionalSearchTerms = 'Change Posting Date,Change Document Date,Change Due Date';
    Caption = 'Change Purchase Cr Memo Posting Date';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;
    //AllowScheduling = true;
    Permissions =
                TableData "User Setup" = rm,
                TableData "Purch. Cr. Memo Hdr." = rm,
                TableData "Purch. Cr. Memo Line" = rm,
                TableData "G/L Entry" = rm,
                TableData "Vendor Ledger Entry" = rm,
                TableData "Detailed Vendor Ledg. Entry" = rm,
                TableData "GST Ledger Entry" = rm,
                TableData "Detailed GST Ledger Entry" = rm,
                TableData "Detailed GST Ledger Entry Info" = rm,
                TableData "Value Entry" = rm;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.", "Posting Date")
                                order(descending);
            column(No; "No.") { }
            trigger OnAfterGetRecord()
            var
            begin
                PurchCrMemoHeader.Reset();
                PurchCrMemoHeader.SetRange("No.", "Purch. Cr. Memo Hdr."."No.");
                if PurchCrMemoHeader.FindFirst() then begin
                    if DocumentDate <> 0D then
                        PurchCrMemoHeader.Validate("Document Date", DocumentDate);
                    if PostingDate <> 0D then
                        PurchCrMemoHeader.Validate("Posting Date", PostingDate);
                    // if OrderDate <> 0D then
                    //     PurchCrMemoHeader."Order Date" := OrderDate;
                    if DueDate <> 0D then
                        PurchCrMemoHeader."Due Date" := DueDate;
                    if VATReportingDate <> 0D then
                        PurchCrMemoHeader."VAT Reporting Date" := VATReportingDate;
                    if PaymentDate <> PaymentDate::" " then
                        PurchCrMemoHeader."Payment Date" := PaymentDate;
                    PurchCrMemoHeader.Modify();

                    PurchCrMemoLine.Reset();
                    PurchCrMemoLine.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if PurchCrMemoLine.FindSet() then
                        repeat
                            PurchCrMemoLine."Posting Date" := PostingDate;
                            PurchCrMemoLine.Modify();
                        until PurchCrMemoLine.Next() = 0;

                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if GLEntry.FindSet() then
                        repeat
                            GLEntry."Document Date" := DocumentDate;
                            GLEntry."Posting Date" := PostingDate;
                            GLEntry."VAT Reporting Date" := VATReportingDate;
                            GLEntry.Modify();
                        until GLEntry.Next() = 0;

                    VendLedgEntry.Reset();
                    VendLedgEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if VendLedgEntry.FindSet() then
                        repeat
                            VendLedgEntry."Document Date" := DocumentDate;
                            VendLedgEntry."Posting Date" := PostingDate;
                            VendLedgEntry."Due Date" := DueDate;
                            VendLedgEntry.Modify();
                        until VendLedgEntry.Next() = 0;

                    DetailVendLedgEntry.Reset();
                    DetailVendLedgEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if DetailVendLedgEntry.FindSet() then
                        repeat
                            DetailVendLedgEntry."Posting Date" := PostingDate;
                            DetailVendLedgEntry."Initial Entry Due Date" := DueDate;
                            DetailVendLedgEntry.Modify();
                        until DetailVendLedgEntry.Next() = 0;

                    DetailGSTLedgEntry.Reset();
                    DetailGSTLedgEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if DetailGSTLedgEntry.FindSet() then
                        repeat
                            DetailGSTLedgEntry."Posting Date" := PostingDate;
                            DetailGSTLedgEntry.Modify();
                        until DetailGSTLedgEntry.Next() = 0;

                    GSTLedgEntry.Reset();
                    GSTLedgEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if GSTLedgEntry.FindSet() then
                        repeat
                            GSTLedgEntry."Posting Date" := PostingDate;
                            GSTLedgEntry.Modify();
                        until GSTLedgEntry.Next() = 0;

                    DetailGSTLedgEntry.Reset();
                    DetailGSTLedgEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    if GSTLedgEntry.FindSet() then
                        repeat
                            GSTLedgEntry."Posting Date" := PostingDate;
                            GSTLedgEntry.Modify();
                        until GSTLedgEntry.Next() = 0;

                    ValueEntry.Reset();
                    ValueEntry.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
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
                    "Purch. Cr. Memo Hdr.".SetRange("No.", DocumentNo);

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
                            PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                        begin
                            PurchCrMemoHeader.Reset();
                            if Page.RunModal(Page::"Posted Purchase Credit Memos", PurchCrMemoHeader) = Action::LookupOK then begin
                                //DocumentNo := VendorLedgerEntry_L."Document No.";
                                Text := PurchCrMemoHeader."No.";
                                DocumentDate := PurchCrMemoHeader."Document Date";
                                PostingDate := PurchCrMemoHeader."Posting Date";
                                DueDate := PurchCrMemoHeader."Due Date";
                                //OrderDate := PurchCrMemoHeader."Order Date";
                                VATReportingDate := PurchCrMemoHeader."VAT Reporting Date";
                                //PaymentDate := PurchInvHeader."Payment Date";
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
                    // field(ShipmentDate; ShipmentDate)
                    // {
                    //     Caption = 'Shipment Date';
                    //     ApplicationArea = All;
                    // }
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
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        GLEntry: Record "G/L Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DetailVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        GSTLedgEntry: Record "GST Ledger Entry";
        DetailGSTLedgEntry: Record "Detailed GST Ledger Entry";
        DetailedGSTLedgEntryInfo: Record "Detailed GST Ledger Entry Info";
        ValueEntry: Record "Value Entry";

    trigger OnInitReport()
    begin
        AllEntries := false;
        UserSetup_G.Get(UserId);
        if not UserSetup_G."Special Permission" then
            Error('You Do not have Special Permission to Run this Report \ Please Connect Administrator to Provide you Permission');
    end;
}