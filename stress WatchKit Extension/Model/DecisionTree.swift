//
//  DecisionTree.swift
//  stress WatchKit Extension
//
//  Created by Martin Nanchev on 4.06.22.
//

class DesicionTree {
    private var sdnn: Double
    init(sdnn: Double){
        self.sdnn = sdnn
    }
    public func getStressLevel() -> Int {
        var value: Int = 0
        if (self.sdnn <= 57.5) {
            if (self.sdnn <= 24.0) {
                if (self.sdnn <= 7.5) {
                    if (self.sdnn <= 3.5) {
                        if (self.sdnn <= 1.0) {
                            value = 100;
                        }
                        else {
                            value = 98;
                        }
                    }
                    else {
                        value = 95;
                    }
                }
                else {
                    if (self.sdnn <= 16.5) {
                        if (self.sdnn <= 12.5) {
                            if (self.sdnn <= 10.5) {
                                value = 90;
                            }
                            else {
                                if (self.sdnn <= 11.5) {
                                    value = 89;
                                }
                                else {
                                    value = 88;
                                }
                            }
                        }
                        else {
                            if (self.sdnn <= 14.5) {
                                if (self.sdnn <= 13.5) {
                                    value = 87;
                                }
                                else {
                                    value = 86;
                                }
                            }
                            else {
                                value = 85;
                            }
                        }
                    }
                    else {
                        if (self.sdnn <= 19.0) {
                            value = 82;
                        }
                        else {
                            if (self.sdnn <= 21.0) {
                                value = 8;
                            }
                            else {
                                value = 78;
                            }
                        }
                    }
                }
            }
            else {
                if (self.sdnn <= 38.5) {
                    if (self.sdnn <= 33.5) {
                        if (self.sdnn <= 27.0) {
                            value = 74;
                        }
                        else {
                            if (self.sdnn <= 28.5) {
                                value = 72;
                            }
                            else {
                                if (self.sdnn <= 29.5) {
                                    value = 71;
                                }
                                else {
                                    value = 70;
                                }
                            }
                        }
                    }
                    else {
                        value = 63;
                    }
                }
                else {
                    if (self.sdnn <= 46.5) {
                        if (self.sdnn <= 41.5) {
                            value = 60;
                        }
                        else {
                            value = 57;
                        }
                    }
                    else {
                        if (self.sdnn <= 52.5) {
                            value = 50;
                        }
                        else {
                            value = 45;
                        }
                    }
                }
            }
        }
        else {
            if (self.sdnn <= 83.5) {
                if (self.sdnn <= 65.0) {
                    value = 40;
                }
                else {
                    if (self.sdnn <= 75.0) {
                        value = 30;
                    }
                    else {
                        value = 20;
                    }
                }
            }
            else {
                if (self.sdnn <= 92.5) {
                    value = 13;
                }
                else {
                    if (self.sdnn <= 99.5) {
                        if (self.sdnn <= 98.5) {
                            value = 2;
                        }
                        else {
                            value = 1;
                        }
                    }
                    else {
                        value = 0;
                    }
                }
            }
        }
        return value
    }
}
