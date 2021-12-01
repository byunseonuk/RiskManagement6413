/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = async (srv) => {
    srv.after('READ', 'Risks', (risks) => {
        
        if(Array.isArray(risks)) {
            risks.forEach((risk) => {
                if (risk.impact >= 100000) {
                    risk.criticality = 1;
                } else {
                    risk.criticality = 2;
                }
            });
        }else {
            if (risks.impact >= 100000) {
                risks.criticality = 1;
            } else {
                risks.criticality = 2;
            }
        }
    });
}