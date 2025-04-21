package common

import (
	"context"
	"os"
	"strings"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"

	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/deviceprovisioningservices/armdeviceprovisioningservices"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/iothub/armiothub"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestIothub(t *testing.T, ctx types.TestContext) {

	subscriptionID := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionID) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID is not set in the environment variables ")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	iothubClientFactory, err := armiothub.NewClientFactory(subscriptionID, credential, &options)

	if err != nil {
		t.Fatalf("Error creating device provisioning services client: %v", err)
	}

	resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")

	t.Run("CheckIothubId", func(t *testing.T) {
		iothubName := terraform.Output(t, ctx.TerratestTerraformOptions(), "iothub_name")
		iothubId := terraform.Output(t, ctx.TerratestTerraformOptions(), "iothub_id")

		res, err := iothubClientFactory.NewResourceClient().Get(context.Background(), resourceGroupName, iothubName, nil)
		if err != nil {
			t.Fatalf("Error getting iothub object: %v", err)
		}

		assert.Equal(t, strings.ToLower(iothubId), strings.ToLower(*res.ID), "IoT Hub Id's do not match.")
	})

	dpsClientFactory, err := armdeviceprovisioningservices.NewClientFactory(subscriptionID, credential, &options)

	if err != nil {
		t.Fatalf("Error creating device provisioning services client: %v", err)
	}

	t.Run("CheckDeviceProvisioningServiceId", func(t *testing.T) {
		dpsName := terraform.Output(t, ctx.TerratestTerraformOptions(), "iothub_dps_name")
		dpsId := terraform.Output(t, ctx.TerratestTerraformOptions(), "iothub_dps_id")

		res, err := dpsClientFactory.NewIotDpsResourceClient().Get(context.Background(), dpsName, resourceGroupName, nil)
		if err != nil {
			t.Fatalf("Error getting device provisioning service name: %v", err)
		}

		assert.Equal(t, dpsId, *res.ID, "Device Provisioning Service Id's do not match.")
	})

}
