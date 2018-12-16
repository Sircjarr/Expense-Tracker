# Expense-Tracker
A team project that keeps track of capital and operational expenses for a business. With an external database, managers are able to create, read, and update expenses which is reflected in a web application for corporate users to see. The web app source code is not included in this repo since I did not make it. 

<h2>Team</h2>
<ul> 
  <li>Tejasree Vangapalli</li>
  <li>Nathan Welch</li>
  <li>Wes Letcher</li>
</ul>

<h2>Features I did</h2>
<ul>
  <li>Coded pHp files</li>
    <ul>
      <li>Connect to a database</li>
      <li>Secure authentication with pHp hashed password</li>
      <li>CRUD sql operations on database</li>
      <li>Return JSON data of query results</li>
    </ul>
  <li>DatabaseHelper class for REST API calls</li>
    <ul>
      <li>Call the pHp files to manipulate the database</li>
      <li>Pass post data</li>
      <li>Retrieve and use JSON data from some calls</li>
      <li>Update main thread from background thread</li>
    </ul>
    <li>Model and Util Folders</li>
      <ul>
        <li>Expense model reflecting a tuple in the expenses table</li>
        <li>User Variables model storing authenticated user's information</li>
        <li>Static function to call alert dialog from any class instance</li>
      </ul>
</ul>
