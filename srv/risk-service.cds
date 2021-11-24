using { sap.ui.riskmanagement as my } from '../db/schema';
 
@path: 'service/risk'
service RiskService {

    // @ristrict 인증 및 권한 체크, 
  entity Risks @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer6413' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager6413' ]
            }
        ]) as projection on my.Risks;
//### END OF INSERT
    annotate Risks with @odata.draft.enabled;
 
//### BEGIN OF INSERT
  entity Mitigations @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer6413' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager6413' ]
            }
        ]) as projection on my.Mitigations;
//### END OF INSERT
    annotate Mitigations with @odata.draft.enabled;

  view riskmit as 
  select A.impact, B.owner
  from my.Risks as A 
  inner join my.Mitigations as B
   on A.miti_id = B.ID;
}