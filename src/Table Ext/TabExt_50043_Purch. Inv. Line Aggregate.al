tableextension 50043 MyExt extends "Purch. Inv. Line Aggregate"
{
    fields
    {
        field(60000; "HSN Code"; Code[20])
        {
            Caption = 'HSN Code';
            TableRelation = "HSN/SAC".Code where("GST Group Code" = field("GST Group Code"));
        }
        field(60001; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";
        }
        field(60002; "GST Credit"; Enum "GST Credit")
        {
            Caption = 'GST Credit';
        }
        field(60003; "Gen. Business Posting Group"; Code[20])
        {
            Caption = 'Gen. Business Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(60004; "Gen. Product Posting Group"; Code[20])
        {
            Caption = 'Gen. Product Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60005; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }
}
