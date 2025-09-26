import { LightningElement, wire, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getTrainings from '@salesforce/apex/TrainingService.getTrainings';
import updateStatus from '@salesforce/apex/TrainingService.markCompleted';

export default class TrainingList extends LightningElement {
    
    @api recordId;

    @wire(getTrainings, { contactId: '$recordId' }) trainings;

    handleMarkCompleted(event) {
        const trainingId = event.target.dataset.id;
        updateStatus({ trainingId })
            .then(() => {
                return refreshApex(this.trainings);
            });
    }

}