tableextension 50009 "QBA G/L Account" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Opening Bal. Debit"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Debit Amount" where("G/L Account No." = field("No."),
                                                                "G/L Account No." = field(filter(Totaling)),
                                                                "Posting Date" = filter(< '2025-04-01'),
                                                                "Business Unit Code" = field("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                "Posting Date" = field("Date Filter"),
                                                                "VAT Reporting Date" = field("VAT Reporting Date Filter"),
                                                                "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Opening Bal. Debit';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Opening Bal. Credit"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Credit Amount" where("G/L Account No." = field("No."),
                                                                 "G/L Account No." = field(filter(Totaling)),
                                                                 "Posting Date" = filter(< '2025-04-01'),
                                                                 "Business Unit Code" = field("Business Unit Filter"),
                                                                 "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 "VAT Reporting Date" = field("VAT Reporting Date Filter"),
                                                                 "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Opening Bal. Credit';
            Editable = false;
            FieldClass = FlowField;
        }


        // field(50002; "QBA Debit"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     BlankZero = true;
        //     CalcFormula = sum("G/L Entry"."Debit Amount" where("G/L Account No." = field("No."),
        //                                                         "G/L Account No." = field(filter(Totaling)),
        //                                                         "Posting Date" = filter(> '01-04-2024'),
        //                                                         "Business Unit Code" = field("Business Unit Filter"),
        //                                                         "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
        //                                                         "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
        //                                                         "Posting Date" = field("Date Filter"),
        //                                                         "VAT Reporting Date" = field("VAT Reporting Date Filter"),
        //                                                         "Dimension Set ID" = field("Dimension Set ID Filter")));
        //     Caption = 'CFY Debit';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50003; "QBA Credit"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     BlankZero = true;
        //     CalcFormula = sum("G/L Entry"."Credit Amount" where("G/L Account No." = field("No."),
        //                                                          "G/L Account No." = field(filter(Totaling)),
        //                                                          "Posting Date" = filter(> '01-04-2024'),
        //                                                          "Business Unit Code" = field("Business Unit Filter"),
        //                                                          "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
        //                                                          "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
        //                                                          "Posting Date" = field("Date Filter"),
        //                                                          "VAT Reporting Date" = field("VAT Reporting Date Filter"),
        //                                                          "Dimension Set ID" = field("Dimension Set ID Filter")));
        //     Caption = 'CFY Credit';
        //     Editable = false;
        //     FieldClass = FlowField;
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
    procedure CalculateTotalAmount(StartDate: Date; EndDate: Date): Decimal
    var
        SalesLine: Record "Sales Line";
        TotalAmount: Decimal;
        accou: Record "Accounting Period";
    begin
        SalesLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesLine.FindSet() then
            repeat
                TotalAmount += SalesLine."Amount";
            until SalesLine.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure AAAA()
    var
        AccountingPeriod: Record "Accounting Period";
        Date1: Date;
        Date2: Date;
        ghj: Date;
        UserSetupManagement: Codeunit "User Setup Management";
    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SetRange("New Fiscal Year", true);
        AccountingPeriod."Starting Date" := WORKDATE;
        AccountingPeriod.FIND('=<');
        Date1 := AccountingPeriod."Starting Date";
        IF AccountingPeriod.Next() = 0 THEN
            Date2 := 99991231D
        ELSE
            Date2 := AccountingPeriod."Starting Date" - 1;
        UserSetupManagement.CheckAllowedPostingDate(Today);

    end;

    var
        myInt: Integer;
        OpeningDate: Date;
}