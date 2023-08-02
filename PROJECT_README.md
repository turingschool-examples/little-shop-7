<!-- - Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project.  -->
# 🛍️ **Little Esty Shop** 🛍️

## Project Description

"Little Esty Shop" is a mid-mod group project where students are tasked with building a fictitious e-commerce platform. The project aims to create a robust web application that allows merchants and admins to efficiently manage inventory and fulfill customer invoices.
___

## 🔧 Tools Used 🔧 
| Rails 7.0.5 | Ruby 3.2.2 | ActiveRecord |
|:-----------:|:----------:|:------------:|
|  SimpleCov  |   VS Code  |   Capybara   |
|    Github   |   Render   |     RSpec    |
|     HTML    |     SQL    |      Pry     |

______________

## Over View
The main features of "Little Esty Shop" include:

- Inventory Management: Merchants can add, edit, and disable products, ensuring they have control over their store's inventory.

- Invoice Management: Admins can add, enable and disable, and upadte merchants. They can also see all invoices, and update invoice statuses.

- API Integration: The application utilizes a public API to fetch external data, enhancing the user experience with up-to-date information.

- Deployment on Render: The project requires students to deploy the application on the Render platform, showcasing their ability to make the application accessible online.
___
## 💪 Work complete

1. Database Design
In this project, we have carefully designed and implemented the database structure to efficiently store and manage data. Leveraging what we learned in class, we ensured data integrity, and optimal performance.

2. MVC (Model-View-Controller)
We adopted the MVC architectural pattern to organize our application code. The Model represents the data logic, the View handles the presentation logic, and the Controller acts as the intermediary, managing user requests and coordinating data flow between the Model and View. This separation of concerns enhances code maintainability, promotes teamwork among developers, and allows for easier future enhancements.

3. Advanced Routing
To provide a seamless user experience and enable complex interactions within our application, we implemented advanced routing techniques. Our routing system efficiently handles incoming requests and maps them to the appropriate controllers and actions, allowing for dynamic content generation and customization.

4. Active Record
We used the ORM Active Record to interact with the database. Active Record enables us to perform database operations using Ruby objects, abstracting away complex SQL queries. This simplifies data manipulation and database access, reducing development time and potential errors.

5. API Consumption
We integrated API consumption capabilities into our application, enabling interaction with Unsplash. By seamlessly consuming APIs, we enrich our application, and enhance user experience. 

6. POROs (Plain Old Ruby Objects)
We utilized POROs to encapsulate and manage API consumption logic and data manipulation tasks that do not require database interactions. By keeping these operations outside the database layer, we enhance code clarity and maintainability.

7. Deployment on Render
For seamless deployment and high availability, we chose Render as our platform of choice. Render's user-friendly interface, automated scaling, and monitoring features enable us to deliver a reliable and scalable solution to our end-users. With Render, we ensure a smooth user experience and rapid response times.
___
## 🏗️ Next Steps and Potential Refactors

Although we have successfully implemented the project's core functionality, there are several areas that can be further refined and improved to enhance the application's overall robustness and maintainability. Here are some potential next steps and refactors we could explore if given more time:

1. Enhanced Testing with FactoryBot: Implementing FactoryBot for streamlined testing and fixture management. By defining factories for our test data, we can create more reliable and maintainable test cases, leading to better test coverage.

2. Consistent Utilization of Helper Methods: Refactor and expand the use of helper methods throughout the codebase. Utilizing helpers consistently can lead to cleaner, more readable code and promote DRY principles.

3. Partial Rendering for Forms: Employ partials to modularize and simplify form rendering. By using partials, we can avoid code duplication and enhance the maintainability of our view templates.
___

## Contributors

👨 Ethan Black: [Github](https://github.com/ethanrossblack),[LinkedIn](https://www.linkedin.com/in/ethanrossblack/)

 👩 Zanna Fitch; [Github](https://github.com/z-fitch),[LinkedIn](https://www.linkedin.com/in/zanna-fitch-2841a1279/)

👩 Jorja Fleming: [Github](https://github.com/JorjaF),[LinkedIn](https://www.linkedin.com/in/jorja-f-25027a70/)

👨 Daniel Gallagher: [Github](Daniel-Gallagher92),[LinkedIn](https://www.linkedin.com/in/daniel-gallagher-5b29271a1/)

___

## 💐 Acknowledgments 💐
We express our gratitude to our instructors, teaching assistants, and cohort-mates for their guidance and support throughout the development of this project.
