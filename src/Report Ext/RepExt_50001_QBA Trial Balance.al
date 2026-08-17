reportextension 50001 "QBA Trial Balance" extends "Trial Balance"
{
    dataset
    {
        // Add changes to dataitems and columns here
        modify("G/L Account")
        {

        }
        add(Integer)
        {
            column(OpeningCredit; OpeningCredit) { }
            column(OpeningDebit; OpeningDebit) { }
        }
        modify(Integer)
        {
            trigger OnAfterPreDataItem()
            begin
                Clear(OpeningCredit);
                Clear(OpeningDebit);
            end;

            trigger OnAfterAfterGetRecord()
            var
                GlEntry: Record "G/L Entry";
                Result: Text[10];
            begin

                Result := Format(Today, 0, '<Year4><Month,2><Day,2>') + 'D';

                // in Feature we can replace 20240331D from Result for dynamic Calculation

                GlEntry.Reset();
                GlEntry.SetRange("G/L Account No.", "G/L Account"."No.");
                GlEntry.SetFilter("Posting Date", '<=%1', 20240331D);
                GlEntry.SetFilter(Amount, '<%1', 0);
                if GlEntry.FindSet() then
                    repeat
                        OpeningCredit += ABS(GlEntry.Amount);
                    until GlEntry.Next() = 0;

                GlEntry.Reset();
                GlEntry.SetRange("G/L Account No.", "G/L Account"."No.");
                GlEntry.SetFilter("Posting Date", '<=%1', 20240331D);
                GlEntry.SetFilter(Amount, '>%1', 0);
                if GlEntry.FindSet() then
                    repeat
                        OpeningDebit += ABS(GlEntry.Amount);
                    until GlEntry.Next() = 0;
            end;
        }


    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("QBA Layout")
        {
            Caption = 'QBA Trial Balance';
            Type = RDLC;
            LayoutFile = 'src/Report Ext Layout/QBA Trial Balance.rdlc';
        }
    }
    var
        OpeningDebit: Decimal;
        OpeningCredit: Decimal;
        OpeningNetChange: Decimal;
}