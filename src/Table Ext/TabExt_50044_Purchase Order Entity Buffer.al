tableextension 50044 "QBAPurchase Order Ent Buffer" extends "Purchase Order Entity Buffer"
{
    fields
    {
        // Add changes to table fields here
        // field(60000; POStatus; Enum "Purchase Document Status")
        // {
        //     Caption = 'POStatus';
        //     DataClassification = CustomerContent;

        //     // trigger OnValidate()
        //     // begin
        //     //     UpdatePayToVendorId();
        //     // end;
        // }
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
        aaa: Page "Purchase Order Statistics";
        sasda: Page "Purchase Order";
        aaaaa: Record "Purchase Header";
}