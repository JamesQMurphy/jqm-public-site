One DevOps, Please

Does anybody really think that DevOps is something you *buy*?

I certainly hope not.  But I have encountered those who feel that "DevOps" is simply a collection of continuous-integration and continuous-deployment tools.  You know the tools... Chef, Puppet, Ansible, Jenkins, etc.  Pick up any random job spec for a DevOps Engineer and it'll read like a laundry list of every deployment and configuration tool known to modern science.  These listings will usually state some other requirements as well... shell scripting, cloud experience, and Docker are almost universal faves.

It's more than that, of course.  A great definition of DevOps comes from [Donovan Brown](http://donovanbrown.com/post/what-is-devops), Principal DevOps manager at Microsoft:

> DevOps is the union of people, process, and products to enable continuous delivery of value to our end users.

In [his blog entry](http://donovanbrown.com/post/what-is-devops), Mr. Brown explains that DevOps is not merely a set of tools that you purchase.  He explains why he chose the exact words he did, and why he listed them in that order (note that "products" comes after "people" and "process").

Even as concise as that definition is, I would argue that it's a tad biased towards the "Dev" side of the house.  Continuous delivery shouldn't imply that production is the end goal.  Once the software has been "delivered," the job is far from done.  The software is delivered, yet it is the Operations team that has to figure out why processor usage is pinned at 100%, or why the database has started to lock up.  I've seen cases where development has delivered -- *continuously* delivered -- bad software.  A fix eventually comes, but it sometimes takes two or three (continuous) deliveries.  (True, one could argue that in these cases, it is not value that you are delivering, but remember, it worked just fine in QA...)

In my experience, the definition of DevOps is more along the lines of this:

> DevOps forces development to make software fit for operations.

Why *force*?  Because of something I've encountered time and time again:  most software developers simply *do not know* what makes software "fit for operations."  And this is where DevOps comes in.  A great DevOps team knows more than simply how to configure Jenkins and Puppet.  They know that the software they are deploying must be fit.  They know that if it doesn't handle errors gracefully, or if it can't be restarted at any time, or that if it consumes endless amounts of RAM and disk space, it isn't fit for operations.  Operations should never *see* software like that.

I've got lots of examples where unfit software made it to production, and I'm sure I'll encounter more.  I'll blog about the more interesting ones.
