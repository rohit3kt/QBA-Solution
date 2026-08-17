report 50029 "Delete General Ledger Entries"
{
    AdditionalSearchTerms = 'Delete General Ledger Entries,Clean General Ledger Entries';
    Caption = 'Delete General Ledger Entries';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;
    //AllowScheduling = true;
    // Permissions =
    //     tabledata "G/L Entry" = RIMD,
    //     tabledata "User Setup" = R; Commented for security

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date")
                                order(descending);
            column(Entry_No_; "Entry No.") { }
            trigger OnAfterGetRecord()
            var
            begin
                // GlEntries_G.Reset();
                // GlEntries_G.SetRange("Document No.", "G/L Entry"."Document No.");
                // GlEntries_G.SetRange("Posting Date", "G/L Entry"."Posting Date");
                // GlEntries_G.DeleteAll();
                // Counter += 1;   Commented for security
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
                        "G/L Entry".SetRange("Document No.", DocumentNo);

                    if ((StartDate <> 0D) AND (EndDate <> 0D)) then
                        "G/L Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                    if ((StartDate = 0D) AND (EndDate <> 0D)) then
                        "G/L Entry".SetFilter("Posting Date", '%1..%2', 0D, EndDate);

                    if ((StartDate <> 0D) AND (EndDate = 0D)) then
                        "G/L Entry".SetRange("Posting Date", StartDate);
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
                            GLEntry_L: Record "G/L Entry";
                        begin
                            GLEntry_L.Reset();
                            if Page.RunModal(Page::"General Ledger Entries", GLEntry_L) = Action::LookupOK then begin
                                //DocumentNo := VendorLedgerEntry_L."Document No.";
                                Text := GLEntry_L."Document No.";
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
        GlEntries_G: Record "G/L Entry";
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