using System;

namespace JamesQMurphy.PublicSite.Models
{
    public class BlogArticle
    {
        public string Title { get; set; }
        public string Slug { get; set; }
        public DateTime PublishDate { get; set; }
        public string Content { get; set; }
        public string Html => Markdig.Markdown.ToHtml(this.Content);
    }
}
