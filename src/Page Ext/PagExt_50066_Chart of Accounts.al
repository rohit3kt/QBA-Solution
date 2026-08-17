pageextension 50066 "QBA Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Opening Bal. Debit"; Rec."Opening Bal. Debit")
            {
                ApplicationArea = All;
            }
            field("Opening Bal. Credit"; Rec."Opening Bal. Credit")
            {
                ApplicationArea = All;
            }
            field(OpeningBalNetChange; OpeningBalNetChange)
            {
                ApplicationArea = All;
                Caption = 'Opening Bal. Net Change';
                AutoFormatType = 1;
            }
        }
        //.......Kallol Change..........++
        addafter(Balance)
        {
            field("Debit Amount_"; Rec."Debit Amount")
            {
                ApplicationArea = all;
                Caption = 'Debit Amount';
            }
            field("Credit Amount_"; Rec."Credit Amount")
            {
                ApplicationArea = all;
                Caption = 'Credit Amount';
            }
        }
        //.......Kallol Change............--

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var

    begin
        Rec.CalcFields("Opening Bal. Credit");
        Rec.CalcFields("Opening Bal. Debit");
        //OpeningBalNetChange := Rec."Opening Bal. Credit" - Rec."Opening Bal. Debit";
        OpeningBalNetChange := Rec."Opening Bal. Debit" - Rec."Opening Bal. Credit";


        // OpeningDebit := GetDebitAmount(Rec."Date Filter");
        // OpeningCredit := GetCreditAmount(Rec."Date Filter");..

    end;

    // local procedure GetDebitAmount(Date_P: Date): Decimal
    // var
    //     GLEntry: Record "G/L Entry";
    //     CopanyInfo: Record "Company Information";
    //     TempAmt: Decimal;
    // begin
    //     Clear(TempAmt);
    //     GLEntry.Reset();
    //     GLEntry.SetRange("G/L Account No.", Rec."No.");
    //     if Date_P <> 0D then
    //         GLEntry.SetRange("Posting Date", Date_P)
    //     else
    //         GLEntry.SetFilter("Posting Date", '<%1', 20240401D);
    //     if GLEntry.FindSet() then begin
    //         repeat
    //             TempAmt += GLEntry."Debit Amount";
    //         until GLEntry.Next() = 0;
    //     end;
    //     exit(TempAmt);
    // end;

    // local procedure GetCreditAmount(Date_P: Date): Decimal
    // var
    //     GLEntry: Record "G/L Entry";
    //     CopanyInfo: Record "Company Information";
    //     TempAmt: Decimal;
    // begin
    //     Clear(TempAmt);
    //     GLEntry.Reset();
    //     GLEntry.SetRange("G/L Account No.", Rec."No.");
    //     if Date_P <> 0D then
    //         GLEntry.SetRange("Posting Date", Date_P)
    //     else
    //         GLEntry.SetFilter("Posting Date", '<%1', 20240401D);
    //     if GLEntry.FindSet() then begin
    //         repeat
    //             TempAmt += GLEntry."Credit Amount";
    //         until GLEntry.Next() = 0;
    //     end;
    //     exit(TempAmt);
    // end;

    var
        OpeningBalNetChange: Decimal;
        OpeningDebit: Decimal;
        OpeningCredit: Decimal;
}