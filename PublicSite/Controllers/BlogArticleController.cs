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
                Title = "Hello, Blog!",
                PublishDate = new DateTime(2018, 6, 10, 8, 30, 0),
                Slug = "hello-blog",
                Content = "Hello, and welcome to my blog!"
            },

            new BlogArticle()
            {
                Title = "Welcome back!",
                PublishDate = new DateTime(2018, 6, 11, 13, 15, 0),
                Slug = "welcome-back",
                Content = "Welcome back!  This is my second entry."
            },

        };

        [HttpGet()]
        public IEnumerable<BlogArticle> GetAll()
        {
            return _blogArticles;
        }
    }
}