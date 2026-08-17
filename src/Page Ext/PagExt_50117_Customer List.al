pageextension 50117 "QBA Customer List" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(ApplyTemplate)
        {
            action(CreateEntry)
            {
                Caption = 'Create CLE';
                ApplicationArea = All;
                Image = Create;
                trigger OnAction()
                var
                    EventSub: Codeunit "QBA Event Subscriber";
                    InputBox: Page "CLE Input Box";
                    TempEntryNo: Integer;
                    Customer: Record "Customer";
                begin
                    InputBox.LookupMode := true;
                    if InputBox.RunModal() <> Action::LookupOK then
                        Error('Process has been aborted!');
                    TempEntryNo := InputBox.GetEntryNo();
                    if EventSub.CreateCLE(TempEntryNo, Rec."No.") then
                        Message('CLE has been created successfully!')
                    else
                        Error('CLE creation failed!');

                end;
            }
        }
        addafter(ApplyTemplate_Promoted)
        {
            actionref("CreateEntry_Promoted"; CreateEntry)
            {
            }
        }

    }

    var
        myInt: Integer;
}