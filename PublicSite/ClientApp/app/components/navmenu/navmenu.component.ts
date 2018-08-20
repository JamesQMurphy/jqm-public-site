import { Component } from '@angular/core';
import { environment } from '../../environments/environment';

@Component({
    selector: 'nav-menu',
    templateUrl: './navmenu.component.html'
})
export class NavMenuComponent {
    public siteName: string = environment.siteName;
}
