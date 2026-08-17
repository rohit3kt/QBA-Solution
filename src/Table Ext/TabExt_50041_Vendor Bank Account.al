tableextension 50041 "QBA Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Beneficiary Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Beneficiary ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Payment Mode"; Option)
        {
            OptionMembers = " ",FT,NEFT,RTGS,IMPS;
            OptionCaption = ' ,FT,NEFT,RTGS,IMPS';
        }
        modify("Vendor No.")
        {
            trigger OnBeforeValidate()
            var
                RecVendor: Record Vendor;
            begin
                if "Vendor No." <> '' then begin
                    if RecVendor.Get(Rec."Vendor No.") then begin
                        "Beneficiary Name" := RecVendor.Name;
                    end;
                end;
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