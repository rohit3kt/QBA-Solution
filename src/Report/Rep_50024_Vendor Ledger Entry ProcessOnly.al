report 50024 "Delete Vendor Ledger Entries"
{
    AdditionalSearchTerms = 'Delete Vendor Ledger Entries Related Entries,Clean Vendor Ledger Entries';
    Caption = 'Delete Vendor Ledger Entries';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;
    //AllowScheduling = true;
    Permissions =
        tabledata "Detailed Vendor Ledg. Entry" = RIMD,
        tabledata "G/L Entry" = RIMD,
        tabledata "User Setup" = R,
        tabledata "Vendor Ledger Entry" = RIMD;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date")
                                order(descending);
            column(Entry_No_; "Entry No.") { }
            trigger OnAfterGetRecord()
            var
            begin
                VendLedgEntries_G.Reset();
                VendLedgEntries_G.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                VendLedgEntries_G.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                if VendLedgEntries_G.FindFirst() then begin
                    GlEntries_G.Reset();
                    GlEntries_G.SetRange("Transaction No.", VendLedgEntries_G."Transaction No.");
                    GlEntries_G.DeleteAll();
                    DetailedVenLedgEntries_G.Reset();
                    DetailedVenLedgEntries_G.SetRange("Transaction No.", VendLedgEntries_G."Transaction No.");
                    DetailedVenLedgEntries_G.DeleteAll();
                    VendLedgEntries_G.Delete();
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
                if not AllEntries then begin
                    if DocumentNo <> '' then
                        "Vendor Ledger Entry".SetRange("Document No.", DocumentNo);

                    if ((StartDate <> 0D) AND (EndDate <> 0D)) then
                        "Vendor Ledger Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                    if ((StartDate = 0D) AND (EndDate <> 0D)) then
                        "Vendor Ledger Entry".SetFilter("Posting Date", '%1..%2', 0D, EndDate);

                    if ((StartDate <> 0D) AND (EndDate = 0D)) then
                        "Vendor Ledger Entry".SetRange("Posting Date", StartDate);
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        SaveValues = true;
        ShowFilter = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter: Vendor Ledger Entry';
                    field(AllEntries; AllEntries)
                    {
                        Caption = 'Delet All Entries';
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            CompanyInfo: Record "Company Information";
                        begin
                            CompanyInfo.Get();
                            if not CompanyInfo."Clear All Record" then begin
                                Message('You are not authorized to Delete All Record on Vendor Ledger Entries \\ Please Enable %1 Field in %2 Table', CompanyInfo.FieldCaption("Clear All Record"), CompanyInfo.TableCaption);
                                Error('');
                            end else begin
                                if AllEntries then begin
                                    DocumentNo := '';
                                    StartDate := 0D;
                                    EndDate := 0D;
                                end;
                            end;
                        end;
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            VendorLedgerEntry_L: Record "Vendor Ledger Entry";
                        begin
                            VendorLedgerEntry_L.Reset();
                            if Page.RunModal(Page::"Vendor Ledger Entries", VendorLedgerEntry_L) = Action::LookupOK then begin
                                //DocumentNo := VendorLedgerEntry_L."Document No.";
                                Text := VendorLedgerEntry_L."Document No.";
                                exit(true);
                            end;
                        end;

                        trigger OnValidate()
                        begin
                            if DocumentNo <> '' then
                                AllEntries := false;
                        end;
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if StartDate <> 0D then
                                AllEntries := false;
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if EndDate <> 0D then
                                AllEntries := false;
                        end;
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
        VendLedgEntries_G: Record "Vendor Ledger Entry";
        GlEntries_G: Record "G/L Entry";
        DetailedVenLedgEntries_G: Record "Detailed Vendor Ledg. Entry";
        DocumentNo: Code[20];
        StartDate: Date;
        EndDate: Date;
        UserSetup_G: Record "User Setup";
        AllEntries: Boolean;
        Counter: Integer;

    trigger OnInitReport()
    begin
        AllEntries := false;
        UserSetup_G.Get(UserId);
        if not UserSetup_G."Special Permission" then
            Error('You Do not have Special Permission to Run this Report \ Please Connect Administrator to Provide you Permission');
    end;
}