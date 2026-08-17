tableextension 50010 "QBA Customer" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "TDS Note"; Text[100])
        {
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