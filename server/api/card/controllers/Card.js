'use strict';
const stripe = require('stripe')('sk_test_s0EjWoG9MlbRW3gNSWjDRaR200edNVGKaS');

/**
 * A set of functions called "actions" for `Card`
 */

module.exports = {
  index: async ctx => {
    const customerId = ctx.request.querystring;
    const customerData = await stripe.customers.retrieve(customerId);
    const cardData = customerData.sources.data;
    ctx.send(cardData);
//    ctx.send('hello motherfuckers')
  }
};
