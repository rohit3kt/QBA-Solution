tableextension 50007 "QBA User Setup" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Special Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Signature_1; BLOB)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(50002; Signature_MediaSet; MediaSet)
        {
            Caption = 'Signature_MediaSet';
            DataClassification = CustomerContent;
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