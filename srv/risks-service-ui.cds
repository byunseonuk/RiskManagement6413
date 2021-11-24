using RiskService from './risk-service';
 
annotate RiskService.Risks with {
  title       @title: 'Title';   // @title UI에 보여지는 헤더 타이틀
  owner       @title: 'Owner';
  prio        @title: 'Priority';
  descr       @title: 'Description';   
  miti_id        @title: 'Mitigation'; 
  //bp          @title: 'Business Partner';   
  impact      @title: 'Impact'; 
}
 
annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);    
	description  @title: 'Description';   
	owner        @title: 'Owner'; 
	timeline     @title: 'Timeline';   
	risks        @title: 'Risks'; 
}
 
annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
            Title: {Value: title},
            Description: {Value: descr}
		},
		SelectionFields: [prio],
		LineItem: [
			{Value: title},
			{Value: miti_id},
            {Value: owner},
			//{Value: bp_BusinessPartner},
			{
				Value: prio,
				Criticality: criticality 
			}
			,
			{
				Value: impact,
				Criticality: criticality
			}
		],
        // Facets, FieldGroup 은 List에서 하나의 Item을 선택시 Detail Page에서 어떤 컬럼들을 보여줄지 설정
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
                {Value: title},
				{Value: miti_id},
				{Value: descr},
				{Value: owner},
				{
					Value: prio,
					Criticality: criticality
				},
				// {Value: bp_BusinessPartner},
				{
					Value: impact,
					Criticality: criticality
				}
            ]
		}		
	},
) {
 
}; 
 
annotate RiskService.Risks with {
    // 다른 값으로 치환해서 보여주고 싶을 때
	miti_id @(	
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut', 
						LocalDataProperty: miti_id, 
						ValueListProperty: 'ID' 
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly', 
						ValueListProperty: 'description' 
					}                                      
				]
			}
		}
	);
  /*
	bp @(	
		Common: {
			Text: bp.LastName  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Business Partners',
				CollectionPath: 'BusinessPartners',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut', 
						LocalDataProperty: bp_BusinessPartner, 
						ValueListProperty: 'BusinessPartner' 
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly', 
						ValueListProperty: 'LastName' 
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly', 
						ValueListProperty: 'FirstName' 
					}      					                                   
				]
			}
		}
	)	
  */
}
 
/*
annotate RiskService.BusinessPartners with {
	BusinessPartner @(
		UI.Hidden,
		Common: {
		Text: LastName
		}
	);   
	LastName    @title: 'Last Name';  
	FirstName   @title: 'First Name';   
}
*/