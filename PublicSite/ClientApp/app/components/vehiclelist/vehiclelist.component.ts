import { Component, Inject } from '@angular/core';
import { Http } from '@angular/http';

@Component({
    selector: 'vehicle-list',
    templateUrl: './vehiclelist.component.html'
})
export class VehicleListComponent {
    public vehicles: vehicle[];

    constructor(http: Http, @Inject('BASE_URL') baseUrl: string) {
        http.get(baseUrl + 'api/Vehicle').subscribe(result => {
            this.vehicles = result.json() as vehicle[];
        }, error => console.error(error));
    }
}

interface vehicle {
    vehicleId: string;
    year: number;
    make: string;
    model: string;
}
