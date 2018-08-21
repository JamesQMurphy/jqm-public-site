using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using JamesQMurphy.PublicSite.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace PublicSite.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    public class BlogArticleController : Controller
    {
        // TODO: temporarily serve up some objects
        private BlogArticle[] _blogArticles = new BlogArticle[]
        {
            new BlogArticle()
            {
                Title = "One DevOps, please!",
                PublishDate = new DateTime(2018, 6, 10, 8, 30, 0),
                Slug = "one-devops-please"
            },

            new BlogArticle()
            {
                Title = "Summer Project",
                PublishDate = new DateTime(2018, 6, 27, 13, 15, 0),
                Slug = "summer-project"
            },

            new BlogArticle()
            {
                Title = "Technology Choices, Part I",
                PublishDate = new DateTime(2018, 6, 28, 12, 0, 0),
                Slug = "technology-choices-1"
            },

        };

        public BlogArticleController()
        {
            foreach(var blogArticle in _blogArticles)
            {
                blogArticle.Content = System.IO.File.ReadAllText($"./blogArticles/{blogArticle.Slug}.md");
            }
        }

        [HttpGet()]
        public IEnumerable<BlogArticle> GetAll()
        {
            return _blogArticles;
        }
    }
}