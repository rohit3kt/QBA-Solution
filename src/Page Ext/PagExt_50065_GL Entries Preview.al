pageextension 50065 "G/LEntriesPreview" extends "G/L Entries Preview"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = all;
            }
        }
    }
}
