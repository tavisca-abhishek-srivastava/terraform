//addAuthor
exports.handler = async (event) => {
    const author = "James Brown";
    const cleanQuote = await sanitizer(event);
   
    console.log("CLEAN ===>",cleanQuote);
    const quote = `${cleanQuote} - by ${author}`;
    // TODO implement
    const response = {
        statusCode: 200,
        body: quote
        //body: JSON.stringify(quote),
    };
    return response;
  };
  async function sanitizer(event) {
  
    return event.body.split("Quote:")[1];
     
  }