
train <- fread("train.csv", key=c("id"))
test <- fread("C:\\Users\\HP LAP\\Desktop\\Kaggle\\Data\\test\\test.csv", key=c("id"))
stopwords.en <- fread("stopwords-en.txt")

profane <- c("damn", "dyke", "fuck", "shit", "ahole", "amcik", "andskota", "anus", 
             "arschloch", "arse", "ash0le", "ash0les", "asholes", "ass", "Ass Monkey", "Assface", 
             "assh0le", "assh0lez"     , "asshole", "assholes", "assholz", "assrammer", "asswipe", "ayir", 
             "azzhole", "b00b", "b00bs", "b17ch", "b1tch", "bassterds", "bastard", 
             "bastards", "bastardz", "basterds", "basterdz", "bi7ch", "Biatch", "bitch", "bitch", 
             "bitches", "Blow Job", "blowjob", "boffing", "boiolas", "bollock", "boobs", "breasts", 
             "buceta", "butt-pirate", "butthole", "buttwipe", "c0ck", "c0cks", 
             "c0k", "cabron", "Carpet Muncher", "cawk", "cawks", "cazzo", "chink", "chraa", "chuj", 
             "cipa", "clit", "Clit", "clits", "cnts", "cntz", "cock", "cock-head", "cock-sucker", 
             "Cock", "cockhead", "cocks", "CockSucker", "crap", "cum", "cunt", 
             "cunt", "cunts", "cuntz", "d4mn", "daygo", "dego", "dick", "dick", "dike", "dild0", 
             "dild0s", "dildo", "dildos", "dilld0", "dilld0s", "dirsa", "dominatricks", "dominatrics", 
             "dominatrix", "dupa", "dyke", "dziwka", "ejackulate", "ejakulate", "Ekrem", "Ekto", "enculer", 
             "enema", "f u c k", "f u c k e r", "faen", "fag", "fag", "fag1t", "faget", 
             "fagg1t", "faggit", "faggot", "fagit", "fags", "fagz", "faig", "faigs", "fanculo", "fanny", 
             "fart", "fatass", "fcuk", "feces", "feg", "Felcher", "ficken", "fitt", "Flikker", "flipping the bird", 
             "foreskin", "Fotze", "fuck", "fucker", "fuckin", "fucking", "fucks", "Fudge Packer", "fuk", "fuk", 
             "Fukah", "Fuken", "fuker", "Fukin", "Fukk", "Fukkah", "Fukker", "Fukkin", "futkretzn", "fux0r", 
             "g00k", "gay", "gayboy", "gaygirl", "gays", "gayz", "God-damned", "gook", 
             "guiena", "h00r", "h0ar", "h0r", "h0re", "h4x0r", "hell", "hells", "helvete", "hoar", "hoer", 
             "hoer", "honkey", "hoore", "hore", "Huevon", "hui", "injun", "jackoff", "jap", "japs", "jerk-off",
             "jisim", "jism", "jiss", "jizm", "jizz", "kanker", "kawk", "kike", "klootzak", "knob", "knobs", 
             "knobz", "knulle", "kraut", "kuk", "kuksuger", "kunt", "kunts", "kuntz", "Kurac", "kurwa", "kusi", 
             "kyrpa", "l3i+ch", "l3itch", "lesbian", "Lesbian", "lesbo", "Lezzian",  
             "Lipshitz", "mamhoon", "masochist", "masokist", "massterbait", "masstrbait", "masstrbate", 
             "masterbaiter", "masterbat", "masterbat3", "masterbate", "masterbates", "masturbat", "masturbate", 
             "merd", "mibun", "mofo", "monkleigh", "Motha Fucker", "Motha Fuker", "Motha Fukkah", "Motha Fukker", 
             "mother-fucker", "Mother Fucker", "Mother Fukah", "Mother Fuker", "Mother Fukker", "motherfucker", 
             "mouliewop", "muie", "mulkku", "muschi", "Mutha Fucker", "Mutha Fukah", "Mutha Fuker", 
             "Mutha Fukkah", "Mutha Fukker", "n1gr", "nastt", "nazi", "nazis", "nepesaurio", "nigga", "nigger", 
             "nigger", "nigger;", "nigur;", "niiger;", "niigr;", "nutsack", "orafis", "orgasim;", "orgasm", "orgasum", 
             "oriface", "orifice", "orifiss", "orospu", "p0rn", "packi", "packie", "packy", "paki", "pakie", "paky", 
             "paska", "pecker", "peeenus", "peeenusss", "peenus", "peinus", "pen1s", "penas", "penis", "penis-breath", 
             "penus", "penuus", "perse", "Phuc", "phuck", "Phuck",  "Phuker", "Phukker", "picka", "pierdol", "pillu", 
             "pimmel", "pimpis", "piss", "pizda", "polac", "polack", "polak",  "poontsee", "poop", "porn", "pr0n", 
             "pr1c", "pr1ck", "pr1k", "preteen", "pula", "pule", "pusse", "pussee", "pussy", "puto", "puuke", "puuker", 
             "qahbeh", "queef", "queer", "queers", "queerz", "qweers", "qweerz", "qweir", "rautenberg", 
             "rectum", "retard", "sadist", "scank", "schaffer", "scheiss", "schlampe", "schlong", "schmuck", "screw", 
             "screwing", "scrotum", "semen", "sex", "sexy", "sh!t", "Sh!t", "sh!t", "sh1t", "sh1ter", "sh1ts", "sh1tter", 
             "sh1tz", "sharmuta", "shemale", "shi+", "shipal", "shit", "shits", "shitter", "Shitty", "Shity", "shitz", 
             "shiz", "Shyt", "Shyte", "Shytty",  "skanck", "skank", "skankee", "skankey", "skanks", "Skanky", "skribz", 
             "skurwysyn", "slut", "sluts", "Slutty", "slutz", "son-of-a-bitch", "sphencter", "spic", "spierdalaj", 
             "splooge", "suka", "teets", "teez", "testical", "testicle", "testicle", "tit", "tits", "titt", "titt", 
             "turd", "twat", "va1jina", "vag1na", "vagiina", "vagina", "vaj1na", "vajina", "vittu",  
             "vulva", "w00se", "w0p", "wank", "wank", "wetback", "wh00r", "wh0re", "whoar", "whore", 
             "wichser", "wop", "xrated", "xxx", "Lipshits", "Mother Fukkah", "zabourah", "Phuk", "Poonani", 
             "puta", "recktum", "sharmute", "Shyty", "smut", "vullva", "yed")


stowwords.custom <- c("put", "far", "bit", "well", "article", "articles", "edit", "edits", "page", "pages",
                      "talk", "page", "editor", "ax", "edu", "subject", "lines", "like", "likes", "line",
                      "uh", "oh", "also", "get", "just", "hi", "hello", "ok", "editing", "edited",
                      "dont", "use", "need", "take", "wikipedia", "give", "say",
                      "look", "one", "make", "come", "see", "said", "now",
                      "wiki", "know", "talk", "read", "hey", "time", "still",
                      "user", "day", "want", "tell", "edit", "even", "ain't", "wow", "image", "jpg", "copyright",
                      "sentence", "wikiproject", "background color", "align", "px", "pixel",
                      "org", "com", "en", "ip", "ip address", "http", "www", "html", "htm",
                      "wikimedia", "https", "httpimg", "url", "urls", "utc", "uhm","username","wikipedia",
                      "what", "which", "who", "whom", "this", "that", "these", "those", 
                      "was", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did",
                      "doing", "would", "should", "could", "ought", "isn't", "aren't", "wasn't", "weren't", "hasn't",
                      "haven't", "hadn't", "doesn't", "don't", "didn't", "won't", "wouldn't", "shan't", "shouldn't",
                      "can't", "cannot", "couldn't", "mustn't", "let's", "that's", "who's", "what's", "here's",
                      "there's", "when's", "where's", "why's", "how's", "a", "an", "the", "and", "but", "if",
                      "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against",
                      "between", "into", "through", "during", "before", "after", "above", "below", "to", "from",
                      "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once",
                      "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more",
                      "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than",
                      "too", "very","articl","ani")

#train <- train %>% mutate(filter="train")
test <- test %>% mutate(filter="test")

#all_comments <- train %>% bind_rows(test)
#all_comments <- train 
all_comments <- test 

#all_comments <- all_comments[1:100,]
nrow(all_comments)


#******************************Train***************************************
# Create some new features relative to use of punctuation, emotj, ...
all_comments.features <- all_comments %>% 
  
  select(id, comment_text) %>% 
  mutate(
    length = str_length(comment_text),
    
    use_cap = str_count(comment_text, "[A-Z]"),
    cap_len = use_cap / length,
    use_cap3plus = str_count(comment_text, "\\b[A-Z]{3,}\\b"),
    cap_len3plus = use_cap3plus / length,
    use_lower = str_count(comment_text, "[a-z]"),
    low_len = use_lower / length,
    
    
    image_cnt = str_count(comment_text, "\\b[\\w|:]*\\.(jpg|png|svg|jpeg|tiff|gif|bmp)\\b"),
    link_cnt = str_count(comment_text, "((f|ht)tp(s?)://\\S+)|(http\\S+)|(xml\\S+)"),
    wikilink_cnt = str_count(comment_text, "Wikipedia:(\\w|[[:punct:]])+\\b"),
    graph_cnt = str_count(comment_text, "[^[:graph:]]"),
    email_cnt = str_count(comment_text, "\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\b"),
    fact_cnt = image_cnt + link_cnt + wikilink_cnt + graph_cnt + email_cnt,
    nicknames_cnt = str_count(comment_text, "@\\w+"),
    
    
    use_exl = str_count(comment_text, fixed("!")),
    use_space = str_count(comment_text, fixed(" ")),
    use_double_space = str_count(comment_text, fixed("  ")),
    use_quest = str_count(comment_text, fixed("?")),
    use_punt = str_count(comment_text, "[[:punct:]]"),
    use_digit = str_count(comment_text, "[[:digit:]]"),
    digit_len = use_digit / length,
    use_break = str_count(comment_text, fixed("\n")),
    use_invis = str_count(comment_text, fixed("\\p{C}")),
    
    use_word = str_count(comment_text, "\\w+"),
    word_len = use_word / length,
    
    use_symbol = str_count(comment_text, "&|@|#|\\$|%|\\*|\\^"),
    use_symbol2plus = str_count(comment_text, "[&|@|#|\\$|%|\\*|\\^]{2,}"),
    use_symbol3plus = str_count(comment_text, "[&|@|#|\\$|%|\\*|\\^]{3,}"),
    use_symbol = use_symbol/ length,
    
    use_char = str_count(comment_text, "\\W*\\b\\w\\b\\W*"),
    use_i = str_count(comment_text, "(\\bI\\b)|(\\bi\\b)"),
    i_len = use_i / length,
    
    
    char_len = use_char / length,
    symbol_len = use_symbol / length,
    use_emotj = str_count(comment_text, "((?::|;|=)(?:-)?(?:\\)|D|P))"),
    cap_emo = use_emotj / length,
    
    prop_emot = str_count(replace_emoticon(comment_text))/ length,
    prop_names = str_count(replace_names(comment_text))/ length,
    prop_emoj = str_count(replace_emoji(comment_text))/ length,
    prop_kern = str_count(replace_kern(comment_text))/ length,
    prop_abbv = str_count(replace_abbreviation(comment_text))/ length,
    prop_contra = str_count(replace_contraction(comment_text))/ length,
    prop_slang = str_count(replace_internet_slang(comment_text))/ length,
    
    word_cnt = str_count(comment_text, "\\w+"),
    word_avglen = length / word_cnt,
    shit_prop = str_count(replace_word_elongation(comment_text))/length,
    use_nonascii = str_count(comment_text, "[^[:ascii:]]"),
    avg_sent = ((sentiment_by(get_sentences(comment_text)))[[4]]),
    uniqueword = lengths(regmatches(uniqueWords(comment_text), gregexpr("\\w+", uniqueWords(comment_text)))),
    prop_unique = uniqueword/lengths(regmatches(comment_text, gregexpr("\\w+", comment_text))),
    
    n_fword = str_count(comment_text, paste(profane,collapse = '|')),
    prop_fword = n_fword/word_cnt
    
  ) %>% 
  select(-id) %T>% 
  glimpse()

#count stopwords
all_comments.features$propstopwords_cnt <- str_count(removeWords(all_comments.features$comment_text, stopwords("en")))
all_comments.features$propstopwords <- str_count(removeWords(all_comments.features$comment_text, stopwords("en")))/all_comments.features$length

#Package conversions
all_comments.features$comment_text <- iconv(all_comments.features$comment_text, to='ASCII//TRANSLIT')

all_comments.features$comment_text <- replace_emoticon(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_emoji(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_kern(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_abbreviation(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_contraction(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_names(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_word_elongation(all_comments.features$comment_text) 
all_comments.features$comment_text <- replace_internet_slang(all_comments.features$comment_text) 


#POS Features
posdat_count <- counts(pos(all_comments.features$comment_text,progress.bar = TRUE, 
                           parallel = TRUE, cores = detectCores()))
if (length(posdat_count) == 2){
  posdat_prop <- data.frame()
  posdat_prop[1,1] <- posdat_count[1,1]
  colnames(posdat_prop)[1] <- "pos_prp_wrd.cnt"
  colnames(posdat_prop)[2] <- paste0("pos_prp_", colnames(posdat_count)[2])
} else {
  posdat_prop <- proportions(pos(all_comments.features$clean_comment_text,progress.bar = FALSE,
                                 parallel = TRUE, cores = detectCores()))
  names(posdat_prop) = paste0("pos_prp_", names(posdat_prop))
}
names(posdat_count) = paste0("pos_cnt_", names(posdat_count))
all_comments.features <- cbind(all_comments.features,posdat_count,posdat_prop)
gc()



head(all_comments.features)
nrow(all_comments.features)










#Run it for both train and test and then combine

all_comments.features <- all_comments.features %>% mutate(filter="train")
all_comments.features_test <- all_comments.features_test %>% mutate(filter="test")
all_comments.features <- all_comments.features %>% bind_rows(all_comments.features_test)














# Remove all special chars, clean text and trasform words
all_comments.clean <- all_comments.features %$%
  str_to_lower(comment_text) %>%
  # clear link
  str_replace_all("(f|ht)tp(s?)://\\S+", " ") %>%
  str_replace_all("http\\S+", "") %>%
  str_replace_all("xml\\S+", "") %>%
  str_replace_all("\\b\\w*:*\\w*\\.(jpg|png|svg|jpeg|tiff|gif|bmp)\\b", "") %>%
  str_replace_all("((f|ht)tp(s?)://\\S+)|(http\\S+)|(xml\\S+)", "") %>%
  #str_replace_all("Wikipedia:(\\w|[[:punct:]])+\\b", "") %>%
  str_replace_all("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\b", "") %>%
  str_replace_all("\n", "") %>%
  #str_replace_all("\\p{C}", "") %>%
  
  # multiple whitspace to one
  str_replace_all("\\s{2}", " ") %>%
  
  # transform short forms
  str_replace_all("what's", "what is ") %>%
  str_replace_all("\\'s", " is ") %>%
  str_replace_all("\\'ve", " have ") %>%
  str_replace_all("can't", "cannot ") %>%
  str_replace_all("n't", " not ") %>%
  str_replace_all("i'm", "i am ") %>%
  str_replace_all("\\'re", " are ") %>%
  str_replace_all("\\'d", " would ") %>%
  str_replace_all("\\'ll", " will ") %>%
  str_replace_all("\\'scuse", " excuse ") %>%
  str_replace_all("pleas", " please ") %>%
  str_replace_all("sourc", " source ") %>%
  str_replace_all("peopl", " people ") %>%
  str_replace_all("remov", " remove ") %>%
  
  # multiple whitspace to one
  str_replace_all("\\s{2}", " ") %>%
  
  # transform shittext
  str_replace_all("(a|e)w+\\b", "") %>%
  str_replace_all("(y)a+\\b", "") %>%
  str_replace_all("(w)w+\\b", "") %>%
  str_replace_all("((a+)|(h+))(a+)((h+)?)\\b", "") %>%
  str_replace_all("((lol)(o?))+\\b", "") %>%
  str_replace_all("n ig ger", " nigger ") %>%
  str_replace_all("s hit", " shit ") %>%
  str_replace_all("g ay", " gay ") %>%
  str_replace_all("f ag got", " faggot ") %>%
  str_replace_all("c ock", " cock ") %>%
  str_replace_all("cu nt", " cunt ") %>%
  str_replace_all("idi ot", " idiot ") %>%
  str_replace_all("f u c k", " fuck ") %>%
  str_replace_all("fu ck", " fuck ") %>%
  str_replace_all("f u ck", " fuck ") %>%
  str_replace_all("c u n t", " cunt ") %>%
  str_replace_all("s u c k", " suck ") %>%
  str_replace_all("c o c k", " cock ") %>%
  str_replace_all("g a y", " gay ") %>%
  str_replace_all("ga y", " gay ") %>%
  str_replace_all("i d i o t", " idiot ") %>%
  str_replace_all("cocksu cking", "cock sucking") %>%
  str_replace_all("du mbfu ck", "dumbfuck") %>%
  str_replace_all("cu nt", "cunt") %>%
  str_replace_all("(?<=\\b(fu|su|di|co|li))\\s(?=(ck)\\b)", "") %>%
  str_replace_all("(?<=\\w(ck))\\s(?=(ing)\\b)", "") %>%
  str_replace_all("(?<=\\b\\w)\\s(?=\\w\\b)", "") %>%
  str_replace_all("((lol)(o?))+", "") %>%
  str_replace_all("(?<=\\b(fu|su|di|co|li))\\s(?=(ck)\\b)", "") %>%
  str_replace_all("(?<=\\w(uc))\\s(?=(ing)\\b)", "") %>%
  str_replace_all("(?<=\\b(fu|su|di|co|li))\\s(?=(ck)\\w)", "") %>%
  str_replace_all("(?<=\\b(fu|su|di|co|li))\\s(?=(k)\\w)", "c") %>%
  
                                                                                                                   
  
  str_replace_all(fixed("sh*t"), "shit") %>%
  str_replace_all(fixed("$h*t"), "shit") %>%
  str_replace_all(fixed("$#*!"), "shit") %>%
  str_replace_all(fixed("$h*!"), "shit") %>%
  str_replace_all(fixed("sh!t"), "shit") %>%
  str_replace_all(fixed("@ss"), "ass") %>%
  str_replace_all(fixed("@$$"), "ass") %>%
  str_replace_all(fixed("a$$"), "ass") %>%
  str_replace_all(fixed("f*ck"), "fuck") %>%
  str_replace_all(fixed("f*uck"), "fuck") %>%
  str_replace_all(fixed("f***"), "fuck") %>%
  str_replace_all(fixed("f**k"), "fuck") %>%
  str_replace_all(fixed("c0ck"), "cock") %>%
  str_replace_all(fixed("a55"), "ass") %>%
  str_replace_all(fixed("$h1t"), "shit") %>%
  str_replace_all(fixed("b!tch"), "bitch") %>%
  str_replace_all(fixed("bi+ch"), "bitch") %>%
  str_replace_all(fixed("l3itch"), "bitch") %>%
  str_replace_all(fixed("p*ssy"), "pussy") %>%
  str_replace_all(fixed("d*ck"), "dick") %>%
  str_replace_all(fixed("n*gga"), "nigga") %>%
  str_replace_all(fixed("f*cking"), "fucking") %>%
  str_replace_all(fixed("shhiiitttt"), "shit") %>%
  str_replace_all(fixed("c**t"), "cunt") %>%
  str_replace_all(fixed("a**hole"), "asshole") %>%
  str_replace_all(fixed("@$$hole"), "asshole") %>%
  str_replace_all(fixed("fu"), "fuck you") %>%
  str_replace_all(fixed("wtf"), "what the fuck") %>%
  str_replace_all(fixed("ymf"), "motherfuck") %>%
  str_replace_all(fixed("f*@king"), "fucking") %>%
  str_replace_all(fixed("$#!^"), "shit") %>%
  str_replace_all(fixed("m0+#3rf~ck3r"), "motherfuck") %>%
  str_replace_all(fixed("pi55"), "piss") %>%
  str_replace_all(fixed("c~nt"), "cunt") %>%
  str_replace_all(fixed("c0ck$~ck3r"), "cocksucker") %>%
  
  
  
  
  # clean nicknames
  str_replace_all("@\\w+", " ") %>%
  
  # clean digit
  str_replace_all("[[:digit:]]", " ") %>%
  
  # remove linebreaks
  str_replace_all("\n", " ") %>%
  
  # remove graphics
  #str_replace_all("[^[:graph:]]", " ") %>%
  
  str_replace_all("'s\\b", " ") %>%
  
  
  # remove punctuation (if remain...)
  str_replace_all("[[:punct:]]", " ") %>%
  
  str_replace_all("[^[:alnum:]]", " ") %>%
  
  # remove single char
  str_replace_all("\\W*\\b\\w\\b\\W*", " ")  %>%
  # remove words with len < 2
  str_replace_all("\\b\\w{1,2}\\b", " ")  %>%
  
  # multiple whitspace to one
  str_replace_all("\\s{2}", " ") %>%
  str_replace_all("\\s+", " ")  %>%
  
  
  itoken(tokenizer = tokenize_word_stems)

max_words = 200000

glove = fread("glove840b300dtxt/glove.840B.300d.txt", data.table = FALSE)  %>%
  rename(word=V1)  %>%
  mutate(word=gsub("[[:punct:]]"," ", rm_white(word) ))

word_embed = all_comments.clean %>% 
  left_join(glove)

J = ncol(word_embed)
ndim = J-2
word_embed = word_embed [1:(max_words-1),3:J] %>%
  mutate_all(as.numeric) %>%
  mutate_all(round,6) %>%
  #fill na with 0
  mutate_all(funs(replace(., is.na(.), 0))) 

colnames(word_embed) = paste0("V",1:ndim)
word_embed = rbind(rep(0, ndim), word_embed) %>%
  as.matrix()

word_embed = list(array(word_embed , c(max_words, ndim)))

