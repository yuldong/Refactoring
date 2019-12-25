function statement(invoice, plays) {
    let totalAmount = 0;
    let volumentCredit = 0;
    let result = 'Statement for ${invoice.customer}\n';
    const format = new Intl.NumberFormat("en-US", {
        style: "currency", currency: "USD", minimumFractionDigits: 2
    }).format;

    for (let perf in invoice.performances) {
        const play = plays[perf.playID];
        let thisAmount = amountFor(perf, play);
        volumentCredit += Math.max(perf.audience - 30, 0);
        if ("comedy" == play.type) {
            volumentCredit += Math.floor(perf.audience / 5);
        }

        result += '${play.name}: ${format(thisAmount / 100)} (${perf.audience} sears)\n';
        totalAmount += thisAmount;
    }
    result += 'Amount owed is ${format(totalAmount / 100)}\n';
    result += 'You earned ${volumentCredit} credits';
    return result;
}

function amountFor(perf, play) {
    let result = 0;

    switch (play.type) {
        case "trageday":
            result = 40000;
            if (perf.audience > 30) {
                result += 100 * (perf.audience - 30);
            }
            break;
        case "comedy":
            result = 30000;
            if (perf.audience > 20) {
                result += 10000 +  500 * (perf.audience - 20);
            }
            result += 300 * perf.audience;
            break;
    
        default:
            throw new Error('unknow type: ${play.type}');
    }
    return result
}