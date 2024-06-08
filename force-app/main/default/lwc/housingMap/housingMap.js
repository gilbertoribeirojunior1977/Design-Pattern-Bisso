import { LightningElement, wire, track } from "lwc";
import getHouses from "@salesforce/apex/HouseService.getRecords";
export default class HousingMap extends LightningElement {
    
    incremento = 0;
    clickedButtonLabel;
    mapMarkers;
    error;
    
    @wire(getHouses)
    wiredHouses({ error, data }) {
        if (data) {
            // We are using Javascript Map function to transform the
            this.mapMarkers = data.map((element) => {
                return {
                    location: {
                        Street: element.Address__c,
                        City: element.City__c,
                        State: element.State__c
                    },
                    title: element.Name
                };
            });
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.mapMarkers = undefined;
        }
    }

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
        this.incremento++;
    }

}