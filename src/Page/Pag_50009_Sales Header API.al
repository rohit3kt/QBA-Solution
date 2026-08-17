page 50009 "QBAAPIV2 - Sales Orders Test"
{
    PageType = API;

    APIVersion = 'v2.0';
    APIPublisher = 'QBA';
    APIGroup = 'Agentic';

    EntityCaption = 'Sales Order';
    EntitySetCaption = 'Sales Orders';
    EntityName = 'QBAsalesOrder';
    EntitySetName = 'QBAsalesOrders';

    ChangeTrackingAllowed = true;
    DelayedInsert = true;

    ODataKeyFields = Id;


    SourceTable = "Sales Header Staging";
    Extensible = false;
    AboutText = 'Manages sales order documents including customer details, billing and shipping addresses, order status, delivery dates, and financial totals. Supports full CRUD operations for creating, retrieving, updating, and deleting sales orders, enabling integration with e-commerce platforms, order processing systems, and automated sales workflows. Facilitates synchronization and lifecycle management of sales orders between Business Central and external applications.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(externalDocumentNumber; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(orderDate; Rec."Document Date")
                {
                    Caption = 'Order Date';

                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(customerId; Rec."Customer Id")
                {
                    Caption = 'Customer Id';
                }

                field(customerNumber; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer No.';

                }
                field(customerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                }
                part(QBAsalesOrderLines; "QBAAPIV2-Sale Order Lines Test")
                {
                    Multiplicity = ZeroOrOne;
                    Caption = 'Lines';
                    EntityName = 'QBAsalesOrderLine';
                    EntitySetName = 'QBAsalesOrderLines';
                    SubPageLink = "Document Id" = field(Id);
                }
            }
        }
    }
    actions
    {
    }
    var
    
}