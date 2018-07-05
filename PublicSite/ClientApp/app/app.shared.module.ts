import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule, Router, Routes } from '@angular/router';

import { AppComponent } from './components/app/app.component';
import { NavMenuComponent } from './components/navmenu/navmenu.component';
import { HomeComponent } from './components/home/home.component';
import { ResumeComponent } from './components/resume/resume.component';
import { BlogArticleListComponent } from './components/blogarticlelist/blogarticlelist.component';

const appRoutes: Routes = [
    { path: 'home', component: HomeComponent, data: { title: 'One DevOps, please!' } },
    { path: 'resume', component: ResumeComponent, data: { title: 'Resume - One DevOps, please!' }  },
    { path: 'blog', component: BlogArticleListComponent, data: { title: 'Blog - One DevOps, please!' }  },
    { path: '', redirectTo: 'home', pathMatch: 'full' },
    { path: '**', redirectTo: 'home' }
];

@NgModule({
    declarations: [
        AppComponent,
        NavMenuComponent,
        HomeComponent,
        ResumeComponent,
        BlogArticleListComponent,
    ],
    imports: [
        CommonModule,
        HttpModule,
        FormsModule,
        RouterModule.forRoot(appRoutes)
    ]
})
export class AppModuleShared {
}
