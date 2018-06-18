using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace JamesQMurphy.PublicSite.Models
{
    public class BlogArticle
    {
        public string Title { get; set; }
        public string Slug { get; set; }
        public DateTime PublishDate { get; set; }
        public string Content { get; set; }
    }
}
