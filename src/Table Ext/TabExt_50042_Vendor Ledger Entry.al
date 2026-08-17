tableextension 50042 "QBA Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Exported; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "QBA Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // Rec.CalcFields("Remaining Amt. (LCY)");
                // if "QBA Payment Amount" > Abs(Rec."Remaining Amt. (LCY)") then
                //     Error('Amount can not be greater than Remaining Amount');

                if Rec."QBA Payment Amount" <> xRec."QBA Payment Amount" then
                    Rec."QBA Payment Amount" := Abs(Rec."QBA Payment Amount") * -1;


                if (Rec."QBA Payment Amount" < Rec."Remaining Amt. (LCY)") then
                    Error('Amount can not be greater than Remaining Amount');


                //TestField(Open, true);
            end;
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