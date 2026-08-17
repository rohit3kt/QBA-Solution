report 50015 UpdateGLEntry2
{
    ApplicationArea = All;
    Caption = 'Gl Correction report 2';
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
                recGL.SetFilter("Entry No.", '=%1', 670);
                recGL.SetFilter("Credit Amount", '=%1', CreditAmount);
                recGL.SetFilter(Amount, '=%1', Amount_);
                recGL.SetFilter("Document No.", DocNo);
                recGL.SetFilter("G/L Account No.", GlAccountNo);
                // recGL."Entry No." ///////////////////////
                recGL.Reset();
                //  recGL.SetFilter("Entry No.", '=%1', '');
                if recGL.FindFirst() then begin
                    recGL."Credit Amount" := CreditAmount;
                    recGL.Amount := Amount_;
                    recGL."Debit Amount" := Debit_Amount;
                    if DocNo = '' then
                        recGL."Document No." := recGL."Document No."
                    else if DocNo <> '' then recGL.Validate(recGL."Document No.", DocNo);
                    if GlAccountNo = '' then
                        recGL."G/L Account No." := recGL."G/L Account No."
                    else if GlAccountNo <> '' then recGL."G/L Account No." := GlAccountNo;
                    recGL.Modify(true);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                recGL.Reset();
                // recGL.SetFilter("Entry No.",);
                recGL.SetFilter("Entry No.", '=%1', entry_No);
                if recGL.FindFirst() then //  repeat
                begin
                    recGL."Credit Amount" := CreditAmount;
                    recGL.Amount := Amount_;
                    recGL."Debit Amount" := Debit_Amount;
                    recGL."G/L Account No." := GlAccountNo;
                    //recGL."Bal. Account No." := '201111';
                    recGL.Modify(true);
                end;
                // until recGL.Next = 0;
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
                    field("Bal Acc No"; BalAccNo)
                    {
                        Caption = 'Balancing Acc No.';
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
