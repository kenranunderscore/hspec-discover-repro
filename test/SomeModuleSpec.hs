module SomeModuleSpec (spec) where

import Test.Hspec

spec :: Spec
spec = do
  describe "some description" $ do
    it "works" $ do
      3 `shouldBe` 4
