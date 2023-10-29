<?php
$pageTitle = "Voter Validation"; // Sets the title of the page
$subheaderTitle = "Australian Federal General Elections for House of Representatives"; // Sets the subheader title
$headerTitle = "Welcome to Computersied Voting System"; // Sets the main header title
include('header.php'); // Include the header file
?>
    <div class="container">
        <form action="validate_voter.php" method="post">
            <label for="name">Full Name:<span class="required-asterisk">*</span></label>
            <input type="text" id="name" name="fullname" placeholder="Thu Tran" required>

            <label for="address">Address:<span class="required-asterisk">*</span></label>
            <input type="text" id="address" name="address" placeholder="123 Example St" required
                onkeyup="fetchAddressSuggestions(this, 'address')">
            <div id="addressSuggestions"></div>

            <label for="suburb">Suburb:<span class="required-asterisk">*</span></label>
            <input type="text" id="suburb" name="suburb" placeholder="Melbourne" required
                onkeyup="fetchAddressSuggestions(this, 'suburb')">

            <label for="state">State:<span class="required-asterisk">*</span></label>
            <input type="text" id="state" name="state" placeholder="VIC" required
                onkeyup="fetchAddressSuggestions(this, 'state')">

            <label for="postcode">Postcode:<span class="required-asterisk">*</span></label>
            <input type="text" id="postcode" name="postcode" placeholder="3000" required
                onkeyup="fetchAddressSuggestions(this, 'postcode')">

            <label for="electorateName">Electorate Name:<span class="required-asterisk">*</span></label>
                <input type="text" id="electorateName" name="electorateName" placeholder="Melbourne" required>
                <div style="padding-bottom: 20px;"> 
                <a href="https://electorate.aec.gov.au/" target="_blank">
                    <i class="fas fa-search"></i> Find your Federal Electorates here
                </a>
            </div>

            <label for="votedBefore">Have you voted before in THIS election?<span class="required-asterisk">*</span></label>
            <select id="votedBefore" name="votedBefore" required>
                <option value="" disabled selected>Select an option ˅</option>
                <option value="no">No</option>
                <option value="yes">Yes</option>
            </select>

            <input type="submit" value="REGISTER">
        </form>
    </div>
    <?php 
    include('footer.php'); // Include the footer file 
    ?>

