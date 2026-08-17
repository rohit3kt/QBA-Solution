tableextension 50002 compantInfo extends "Company Information"
{
    fields
    {
        field(50000; "MSME No."; Code[20])
        {
            Caption = 'MSME No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "MSME Type"; Option)
        {
            Caption = 'MSME Type';
            DataClassification = ToBeClassified;
            OptionMembers = "", MICRO, MEDIUM, LARGE;
        }
        field(50002; "MSME Vendor Type"; Option)
        {
            Caption = 'MSME Vendor Type';
            DataClassification = ToBeClassified;
            OptionMembers = "", Registered, Unregistered;
        }
        field(50003; CIN; code[25])
        {
            Caption = 'CIN';
        }
        field(50004; "Document Header Picture"; Blob)
        {
            Caption = 'Document Header Picture';
            Enabled = true;
        }
        field(50005; Picture2; BLOB)
        {
            Caption = 'Picture Header';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated:=true;
            end;
        }
        field(50006; "IEC No."; code[20])
        {
            Caption = 'IEC No.';
        }
        field(50007; "Clear All Record"; Boolean)
        {
            Caption = 'Clear All Record';
            DataClassification = ToBeClassified;
        }
    }
    var 
    PictureUpdated: Boolean;
}
