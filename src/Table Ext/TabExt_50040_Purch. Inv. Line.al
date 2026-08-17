tableextension 50040 "QBA Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        // Add changes to table fields here
        field(50006; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}