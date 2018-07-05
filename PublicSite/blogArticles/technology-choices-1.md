In the previous post, I described my summer project.   But even before I settled the idea of a blog, I knew that I wanted to develop an ASP.NET Core application.  With cross-platform technologies all the rage, I knew I had to be proficient in at *least* one of them.  Learning a client-side responsive framework (Angular, in this case) was going to be challenging enough.  So I decided that for server-side code, I'd stick with what I'd know:  Good old C#.  Well... not really *old* C#... I wanted to get some practice with the newer language features, like [string interpolation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/interpolated).  The point was, I knew C# much better than any of the alternatives (Python, JavaScript, Go, etc.), so the decision was pretty easy.  The app was going to be an ASP.NET Core application, using Angular for the front end.  But where to host it?

# Urgent need for DevOps Engineer with Cloud Experience!

My inbox is littered with these kinds of e-mails (or at least it *would* be if I didn't filter out messages with "urgent need" in the subject).  Nevertheless, pick up any DevOps job requirement and you'll see a need for some sort of cloud platform... usually Amazon Web Services (AWS) or Microsoft's Azure platform.  I had played around with Azure in the past, so I knew I could go that route.  I didn't know that much about AWS, but I had started to dabble a little bit when I was writing a few applications (or *skills*, as they're known) for Amazon Alexa.  [Footnote:  Full disclosure:  My first Alexa Skill was actually implemented as an ASP.NET Web Service hosted in Azure.  Amazon makes it much easier to write Alexa skills using their Lambda engine, but it's totally doable implementing them as a straight Web API that Amazon calls in response to Alexa prompts.]  So I definitely curious to see how “the other half” lived in the AWS world.

# ASP.NET Core on the cheap

But what about cost?  I knew that I wasn't going to get away completely free, but I didn't want to exceed $20/month.  So right away, I knew that I wasn't going to have my own servers (that costs money no matter where you go).  Both Azure and AWS have solutions here.  With Azure, you can host an ASP.NET Core application using their [App Service solution](https://azure.microsoft.com/en-us/services/app-service/).  However, even that gets pricey.  The cheapest level that lets you have your own domain with SSL is their Basic level, and at the time of this writing, their cheapest Basic level tier (B1) runs over $50/month.

AWS, on the other hand, offers their [AWS Free Tier](https://aws.amazon.com/free/?awsf.Free%20Tier%20Types=categories%23alwaysfree), and forgetting about the goodies that are free for a year (yes, a *year*), the list is still impressive.  The two services that caught my eye were DynamoDB (an object database) and Lambda (their serverless compute engine).  The free tier offers 25 GB of Lambda storage, and a whopping *1 million requests per month* for Lambda.

Now, Lambda is typically programmed using JavaScript or Python.  Could Lambda be used for ASP.NET Core?  It turns out, *yes it can*... [Serverless ASP.NET Core 2.0 Application](https://aws.amazon.com/blogs/developer/serverless-asp-net-core-2-0-applications/).  As it turns out, it *has* to be ASP.NET Core 2.0.  *Not* 2.1.  Not even 2.0.6!  But I was still intrigued enough to pursue it.

What about the parts of AWS that you *do* have to pay for?  With AWS, the nice part is that you pay for what you actually use.  First, there's file storage, and that's the [AWS S3](https://aws.amazon.com/s3/pricing/?nc=sn&loc=4) (Simple Storage Solution).  They charge by the GB monthly, and it depends on the AWS region.  For me, using the popular US-East-1 region would cost $2.30/month for 10GB of storage.  Then there's data transfer.  As we'll see later, I made use of [AWS Gateway API](https://aws.amazon.com/api-gateway/pricing/) to expose AWS Lambda and S3 to the outside world.  $3.50/month per million hits in, and $0.09 per GB transferred out.  Not only can you hook up your own domain, you can use SSL (in fact, with Gateway API, you *have* to).  And if you don't mind using Amazon's certificate for your custom domain, that's free too.  Not to sound like an Amazon fan-boy, but this was a fantastic deal.  A real ASP.NET Core site, with SSL, for a few dollars a month until I see actual real traffic.

In case you were wondering, did I ever look at other hosting sites, like GoDaddy?  I didn't, but I didn't have to.  Most of those sites offer straight hosting, with no application tier (PHP if you're lucky to get it).  Scott Hanselman *did* manage to get an ASP.NET Core site running, but it was not a sustainable solution.  [Read about it here.](https://www.hanselman.com/blog/RunningASPNETCoreOnGoDaddysCheapestSharedLinuxHostingDontTryThisAtHome.aspx)

So the list so far...
 * ASP.NET Core 2.0
 * Angular
 * AWS

# Source Control -- the obvious choice

The next choice was an easy one: version control.  Since I am showing how this site is built, the source code needs to be easily available.  And that, of course, means [GitHub](https://www.github.com).  Besides being the obvious choice from that standpoint, there was another factor at play... continuous integration builds and deployments.  I'll discuss that in my next post.  But for now, the list stands as follows:

 * ASP.NET Core 2.0
 * Angular
 * AWS
 * Github
