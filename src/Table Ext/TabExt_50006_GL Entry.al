tableextension 50006 GL_Entry extends "G/L Entry"
{
    fields
    {
        field(50000; "Voucher Narration"; Text[250])
        {
            Caption = 'Voucher Narration';
            DataClassification = ToBeClassified;
            // TableRelation = "Gen. Journal Narration";
        }
        field(50001; "Line Narration"; Text[250])
        {
            Caption = 'Line Narration';
            DataClassification = ToBeClassified;
        }
        field(50100; Narration; Text[100])
        {
            trigger OnValidate()
            begin
                //  enumext := enumext::WDV;
            end;
        }
    }
    var
        enumext: Enum "Depreciation Method";
}
