report 50017 UpdateGLEntry3
{
    ApplicationArea = All;
    Caption = 'Gl Correction report 3';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = RMID;

    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            //RequestFilterFields = "Entry No.";
            //  DataItemTableView = where("Document No." = filter(= 'OPENDO2324/011' | 'OPENDO2324/052'));
            //   DataItemTableView = "G/L Account No." = filter('122000');
            trigger OnPreDataItem()
            begin
                GLEntry.SetFilter("Document No.", '=%1', 'OPEN2324GL/076');
            end;

            trigger OnAfterGetRecord()
            begin
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", 'OPEN2324GL/076');
                if GLEntry.FindFirst() then GLEntry.Delete(true);
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
                    // field(entry_No; entry_No)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Entry No';
                    // }
                    // field(CreditAmount; CreditAmount)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Credit Amount';
                    // }
                    // field(Amount_; Amount_)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Amount';
                    // }
                    // field(Debit_Amount; Debit_Amount)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Debit Amount';
                    // }
                    // field(DocNo; DocNo)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Document No';
                    // }
                    // field(GlAccountNo; GlAccountNo)
                    // {
                    //     Caption = 'GL Account No';
                    //     ApplicationArea = all;
                    // }
                    // field("Bal Acc No"; BalAccNo)
                    // {
                    //     Caption = 'Balancing Acc No.';
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
    var
        entryNo: Code[20]; //integer
        GlAccountNo: Code[25];
        recGL: Record 17;
        DocNo: Code[50];
        faledger: Record "FA Ledger Entry";
        CreditAmount: Decimal;
        Amount_: Decimal;
        entry_No: Integer;
        Debit_Amount: Decimal;
        BalAccNo: code[20];
}
