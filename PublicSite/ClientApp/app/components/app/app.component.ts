import { Component } from '@angular/core';
import { Router, ActivatedRoute, NavigationEnd } from '@angular/router';

@Component({
    selector: 'app',
    templateUrl: './app.component.html'
})
export class AppComponent {
    constructor(private router: Router, private route:ActivatedRoute) { }
    ngOnInit() {
        this.router.events.subscribe((event) => {
            if (event instanceof NavigationEnd) {
                let firstChild = this.route.root.firstChild;
                if (firstChild != null) {
                    // TODO: see https://angular.io/guide/set-document-title
                    console.log('TODO use title service to set title to: ' + firstChild.snapshot.data['title']);
                }
            }
        });
    }
}
