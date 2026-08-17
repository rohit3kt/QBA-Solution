report 50016 UpdateGLEntry_
{
    ApplicationArea = All;
    Caption = 'FA Correction report 2';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "FA Ledger Entry" = RMID;

    dataset
    {
        dataitem(GLEntry; "FA Ledger Entry")
        {
            //RequestFilterFields = "Entry No.";
            //  DataItemTableView = where("Document No." = filter(= 'OPENDO2324/011' | 'OPENDO2324/052'));
            //   DataItemTableView = "G/L Account No." = filter('122000');
            trigger OnPreDataItem()
            begin
                recGL.SetFilter("Entry No.", '=%1', entry_No);
                recGL.SetFilter("Credit Amount", '=%1', CreditAmount);
                recGL.SetFilter(Amount, '=%1', Amount_);
                recGL.SetFilter("Document No.", DocNo);
                // recGL.SetFilter("G/L Account No.", GlAccountNo);
                // recGL."Entry No." ///////////////////////
                recGL.Reset();
                recGL.SetFilter("Entry No.", '=%1', entry_No);
                if recGL.FindFirst() then begin
                    recGL."Credit Amount" := CreditAmount;
                    recGL.Amount := Amount_;
                    recGL."Debit Amount" := Debit_Amount;
                    if DocNo = '' then
                        recGL."Document No." := recGL."Document No."
                    else if DocNo <> '' then recGL.Validate(recGL."Document No.", DocNo);
                    // if GlAccountNo = '' then
                    //     recGL."G/L Account No." := recGL."G/L Account No."
                    // else
                    //     if GlAccountNo <> '' then
                    //         recGL."G/L Account No." := GlAccountNo;
                    recGL.Modify(true);
                end;
                // // recgl.Reset();
                // // '
                // recGL.SetRange("Document No.", '=%!', '');
            end;

            trigger OnAfterGetRecord()
            begin
                // recGL.Reset();
                // recGL.SetFilter("Entry No.", '=%1', entry_No);
                // if recGL.FindFirst() then begin
                //     recGL."Credit Amount" := CreditAmount;
                //     recGL.Amount := Amount_;
                //     recGL."Debit Amount" := Debit_Amount;
                //     recGL.Modify(true);
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
                    field(entry_No; entry_No)
                    {
                        ApplicationArea = all;
                        Caption = 'Entry No';
                    }
                    field(CreditAmount; CreditAmount)
                    {
                        ApplicationArea = all;
                        Caption = 'Credit Amount';
                    }
                    field(Amount_; Amount_)
                    {
                        ApplicationArea = all;
                        Caption = 'Amount';
                    }
                    field(Debit_Amount; Debit_Amount)
                    {
                        ApplicationArea = all;
                        Caption = 'Debit Amount';
                    }
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Document No';
                    }
                    field(GlAccountNo; GlAccountNo)
                    {
                        Caption = 'GL Account No';
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
    var
        entryNo: Integer;
        GlAccountNo: Code[25];
        recGL: Record 5601;
        DocNo: Code[50];
        faledger: Record "FA Ledger Entry";
        CreditAmount: Decimal;
        Amount_: Decimal;
        entry_No: Integer;
        Debit_Amount: Decimal;
}
