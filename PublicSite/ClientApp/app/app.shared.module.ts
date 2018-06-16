import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './components/app/app.component';
import { NavMenuComponent } from './components/navmenu/navmenu.component';
import { HomeComponent } from './components/home/home.component';
import { ResumeComponent } from './components/resume/resume.component';
import { BlogArticleListComponent } from './components/blogarticlelist/blogarticlelist.component';
import { VehicleListComponent } from './components/vehiclelist/vehiclelist.component';

@NgModule({
    declarations: [
        AppComponent,
        NavMenuComponent,
        HomeComponent,
        ResumeComponent,
        BlogArticleListComponent,
        VehicleListComponent
    ],
    imports: [
        CommonModule,
        HttpModule,
        FormsModule,
        RouterModule.forRoot([
            { path: '', redirectTo: 'home', pathMatch: 'full' },
            { path: 'home', component: HomeComponent },
            { path: 'resume', component: ResumeComponent },
            { path: 'blog', component: BlogArticleListComponent },
            { path: 'vehicles', component: VehicleListComponent },
            { path: '**', redirectTo: 'home' }
        ])
    ]
})
export class AppModuleShared {
}
