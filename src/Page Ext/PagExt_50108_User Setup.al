pageextension 50108 "QBA User Setup" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            field("Special Permission"; Rec."Special Permission")
            {
                ApplicationArea = All;
            }
            field(Signature_1; Rec.Signature_1)
            {
                ApplicationArea = All;
            }
            field(ZYPicture; Rec.Signature_MediaSet)
            {
                ApplicationArea = All;
                ShowCaption = false;
                Visible = false;
                ToolTip = 'Specifies the picture that has been inserted for the item Category.';
            }

        }
    }
    actions
    {
        addlast(Processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import Signature';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    ImportFromDevice();
                    UpdatePictureThumbnails();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete Signature';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                    UpdatePictureThumbnails();
                end;
            }
            action(UpdatePictureThumbnails)
            {
                Caption = 'Update Picture Thumbnails';
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                begin
                    if Rec.FindSet() then
                        repeat
                            if Rec.Signature_MediaSet.Count > 0 then begin
                                if TenantMedia.Get(Rec.Signature_MediaSet.Item(1)) then begin
                                    TenantMedia.CalcFields(Content);
                                    Rec.Signature_1 := TenantMedia.Content;
                                    Rec.Modify(true);
                                end;
                            end else begin
                                if Rec.Signature_1.HasValue then begin
                                    Rec.CalcFields(Signature_1);
                                    Clear(Rec.Signature_1);
                                    Rec.Modify(true);
                                end;
                            end;
                        until Rec.Next() = 0;
                    Rec.FindFirst();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Signature_MediaSet.Count <> 0;
    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
        InStr: InStream;
    begin
        Rec.Find();
        Rec.TestField("User ID");
        if Rec."Allow Posting From" = 0D then
            Error(MustSpecifyDescriptionErr);

        if Rec.Signature_MediaSet.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
        if ClientFileName <> '' then
            FileName := FileManagement.GetFileName(ClientFileName);
        //FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec.Signature_MediaSet);
        Rec.Signature_MediaSet.ImportStream(InStr, FileName);
        //Picture.ImportFile(FileName, ClientFileName);
        Rec.Modify(true);
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("User ID");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Signature_MediaSet);
        Rec.Modify(true);
    end;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("User ID");
        Rec.TestField("Allow Posting From");
    end;

    local procedure UpdatePictureThumbnails()
    var
        TenantMedia: Record "Tenant Media";
    begin
        if Rec.FindSet() then
            repeat
                if Rec.Signature_MediaSet.Count > 0 then begin
                    if TenantMedia.Get(Rec.Signature_MediaSet.Item(1)) then begin
                        TenantMedia.CalcFields(Content);
                        Rec.Signature_1 := TenantMedia.Content;
                        Rec.Modify(true);
                    end;
                end else begin
                    if Rec.Signature_1.HasValue then begin
                        Rec.CalcFields(Signature_1);
                        Clear(Rec.Signature_1);
                        Rec.Modify(true);
                    end;
                end;
            until Rec.Next() = 0;
        Rec.FindFirst();
    end;

    var
        myInt: Integer;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        MustSpecifyDescriptionErr: Label 'You must add a description to the item before you can import picture.';
}