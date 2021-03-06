
library(h2o)

h2oServer <- h2o.init(max_mem_size="60g", nthreads=-1)

dx_train <- h2o.importFile(h2oServer, path = "train-0.1m.csv")
dx_test <- h2o.importFile(h2oServer, path = "test.csv")


Xnames <- names(dx_train)[which(names(dx_train)!="dep_delayed_15min")]


system.time({
  md <- h2o.randomForest(x = Xnames, y = "dep_delayed_15min", training_frame = dx_train, ntrees = 500)
})

system.time({
  print(h2o.auc(h2o.performance(md, dx_test)))
})



