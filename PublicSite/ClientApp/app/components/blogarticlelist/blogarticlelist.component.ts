import { Component, Inject } from '@angular/core';
import { Http } from '@angular/http';

@Component({
    selector: 'blogarticle-list',
    templateUrl: './blogarticlelist.component.html'
})
export class BlogArticleListComponent {
    public blogarticles: blogarticle[];

    constructor(http: Http, @Inject('BASE_URL') baseUrl: string) {
        http.get(baseUrl + 'api/BlogArticle').subscribe(result => {
            this.blogarticles = result.json() as blogarticle[];
        }, error => console.error(error));
    }
}

interface blogarticle {
    title: string;
    publishdate: Date;
    slug: string;
    content: string;
}
